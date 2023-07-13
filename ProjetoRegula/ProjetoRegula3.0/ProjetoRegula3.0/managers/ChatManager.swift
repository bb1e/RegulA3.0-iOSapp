//
//  ChatManager.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 08/07/2023.
//

import Firebase
import FirebaseDatabase
import MessageKit

class ChatManager {
    
    ///buscar user atual e juntar o nome
    public func getCurrentUser() {
        guard let currentUser = Auth.auth().currentUser else {
            //just to make sure
            return
        }
        
        let databaseRef = Database.database().reference().child("Users").child(currentUser.uid)
        
        databaseRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let userDict = snapshot.value as? [String: Any],
                  let name = userDict["name"] as? String else {
                return
            }
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(name, forKey: "name")
            userDefaults.set(currentUser.uid, forKey: "uid")
            userDefaults.synchronize()
            
        }
    }
    
    ///buscar nome do outro user
    public func getOtherUserName(senderUID: String, completion: @escaping (String?) -> Void) {
        let userRef = Database.database().reference().child("Users").child(senderUID)
        
        userRef.observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any],
                  let name = userData["name"] as? String else {
                completion(nil)
                return
            }
            completion(name)
        }
    }
    
    
    ///vai buscar os users à real-time database -> dicionário [uid : nome]
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void){
        let databaseRef = Database.database().reference().child("Users")
        
        databaseRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let userSnapshots = snapshot.children.allObjects as? [DataSnapshot] else {
                completion(.success([]))
                return
            }
            
            var users: [[String: String]] = []
            
            for userSnapshot in userSnapshots {
                guard let userDict = userSnapshot.value as? [String: Any],
                      let name = userDict["name"] as? String else {
                    continue
                }
                
                let uid = userSnapshot.key
                
                let user: [String: String] = ["uid": uid, "name": name]
                users.append(user)
            }
            
            completion(.success(users))
            
        }
    }
    
    
    ///cheka se o user não tem msgns nenhumas com o sender - isto serve para direcionar para a conversa já existente ao invés de criar nova
    public func checkIfNoMessages(uid: String, senderUID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let databaseRef = Database.database().reference().child("Messages").child(uid).child(senderUID)
        
        databaseRef.observeSingleEvent(of: .value) { (snapshot) in
            let hasMessages = snapshot.exists()
            completion(.success(!hasMessages))
        }
    }
    
    ///faz fetch e retorna tds as conversas do user
    public func getAllConversations(for userUID: String, completion: @escaping (Result<[Conversation], Error>) -> Void){
        let databaseRef = Database.database().reference().child("Messages").child(userUID)
        
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists(), let conversationsSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                completion(.success([])) // No conversations found, return an empty array
                return
            }
            
            var conversations: [Conversation] = []
            let dispatchGroup = DispatchGroup()
            
            for conversationSnapshot in conversationsSnapshot {
                let senderUID = conversationSnapshot.key
                
                dispatchGroup.enter()
                
                self.getOtherUserName(senderUID: senderUID) { senderName in
                    self.getLastMessage(userID: userUID, senderID: senderUID) { result in
                        let lastMessage: String?
                        
                        switch result {
                        case .success(let message):
                            lastMessage = message
                        case .failure:
                            lastMessage = nil
                        }
                        
                        let conversation = Conversation(userUID: userUID, senderUID: senderUID, senderName: senderName ?? "", lastMessage: lastMessage ?? "")
                        conversations.append(conversation)
                        
                        dispatchGroup.leave()
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(.success(conversations))
            }
        }
    }

    ///fetch de msgns
    func getAllMessagesForConversation(userUID: String, senderUID: String, completion: @escaping (Result<[Message], Error>) -> Void) {

        print("estou na funcao")
        
        let conversationRef1 = Database.database().reference().child("Messages").child(userUID).child(senderUID)
        let conversationRef2 = Database.database().reference().child("Messages").child(senderUID).child(userUID)
        
        var userUIDName = ""
        var senderUIDName = ""
        
        self.getOtherUserName(senderUID: userUID) { senderName in
            userUIDName = senderName ?? ""
        }
        
        self.getOtherUserName(senderUID: senderUID) { senderName in
            senderUIDName = senderName ?? ""
        }
        
        var messages: [Message] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        //time is not working as expected
        //timeFormatter.dateStyle = .none
        //timeFormatter.timeStyle = .short
        
        let group = DispatchGroup()
        
        // Fetch messages from conversationRef1
        group.enter()
        conversationRef1.observeSingleEvent(of: .value) { snapshot in
            guard let messagesSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                print("sem msgns")
                return
            }
            
            for messageSnapshot in messagesSnapshot {
                print("achei msgns")
                //print(messageSnapshot)
                //print(messageSnapshot.value)
                if let messageData = messageSnapshot.value as? [String: Any] {
                    let dateString = messageData["date"] as? String ?? ""
                        let senderID = messageData["from"] as? String ?? ""
                        let messageID = messageData["messageID"] as? String ?? ""
                        let messageText = messageData["message"] as? String ?? ""
                        let timeString = messageData["time"] as? String ?? ""
                        let messageType = messageData["type"] as? String ?? ""
                    
                    //self.getOtherUserName(senderUID: userUID) { senderName in
                        print(senderUIDName)
                        let sender = Sender(senderId: senderID, displayName: userUIDName)
                            //print("depois sender")
                        let stringD = dateString + " " + timeString
                        //print(stringD)
                        if let sentDate = dateFormatter.date(from: stringD) {
                            print("date: \(sentDate)")
                            if let time = timeFormatter.date(from: timeString) {
                            print("time: \(time)")
                                let messageKind: MessageKind
                                
                                if messageType == "text" {
                                    //print("passei pelo tipo")
                                    messageKind = .text(messageText)
                                } else {
                                    messageKind = .text("")
                                }
                                let message = Message(sender: sender, messageId: messageID, sentDate: sentDate, kind: messageKind, time: time)
                                messages.append(message)
                                print("dei append")
                                print("Sender: \(message.sender.displayName)")
                                print("Sender ID: \(message.sender.senderId)")
                                print("Message ID: \(message.messageId)")
                                print("Sent Date: \(message.sentDate)")
                                print("Message Kind: \(message.kind)")
                                print("Time: \(message.time)")
                                print("---")
                            }
                        //}
                    }
                }
                else {
                    print("continuei")
                    continue
                }
            }
            
            group.leave()
        }
        
        // Fetch messages from conversationRef2
        group.enter()
        conversationRef2.observeSingleEvent(of: .value) { snapshot in
            guard let messagesSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                print("sem msgns")
                return
            }
            
            for messageSnapshot in messagesSnapshot {
                //print("achei msgns")
                //print(messageSnapshot)
                //print(messageSnapshot.value)
                if let messageData = messageSnapshot.value as? [String: Any] {
                    let dateString = messageData["date"] as? String ?? ""
                        let senderID = messageData["from"] as? String ?? ""
                        let messageID = messageData["messageID"] as? String ?? ""
                        let messageText = messageData["message"] as? String ?? ""
                        let timeString = messageData["time"] as? String ?? ""
                        let messageType = messageData["type"] as? String ?? ""
                    
                    //print("antes sender")
                    //self.getOtherUserName(senderUID: senderUID) { senderName in
                    let sender = Sender(senderId: senderID, displayName: senderUIDName)
                    //print("depois sender")
                        let stringD = dateString + " " + timeString
                        //print(stringD)
                        if let sentDate = dateFormatter.date(from: stringD) {
                            if let time = timeFormatter.date(from: timeString) {
                                let messageKind: MessageKind
                                
                                if messageType == "text" {
                                    //print("passei pelo tipo")
                                    messageKind = .text(messageText)
                                } else {
                                    messageKind = .text("")
                                }
                                let message = Message(sender: sender, messageId: messageID, sentDate: sentDate, kind: messageKind, time: time)
                                messages.append(message)
                                print("dei append")
                                 print("Sender: \(message.sender.displayName)")
                                 print("Message ID: \(message.messageId)")
                                 print("Sent Date: \(message.sentDate)")
                                 print("Message Kind: \(message.kind)")
                                 print("Time: \(message.time)")
                                 print("---")
                            }
                    }
                }
                else {
                    continue
                }
            }
            
            group.leave()
        }
        print(messages.count)
        print("sucesso")
    
        group.notify(queue: .main) {
            let sortedMessages = messages.sorted { $0.sentDate < $1.sentDate}
            completion(.success(sortedMessages))
        }
    }

    
    ///fica à escuta se uma nova msgm é adicionada à firebase
    func observeNewMessages(userUID: String, senderUID: String) {
        let conversationRef1 = Database.database().reference().child("Messages").child(userUID).child(senderUID)
        let conversationRef2 = Database.database().reference().child("Messages").child(senderUID).child(userUID)
        
        // Observe new messages in real-time from conversationRef1
        conversationRef1.observe(.childAdded) { snapshot in
            self.getAllMessagesForConversation(userUID: userUID, senderUID: senderUID) { result in
                switch result {
                case .success(let messages):
                    // Handle the updated messages array
                    print("New messages: \(messages)")
                case .failure(let error):
                    print("Failed to get new messages: \(error)")
                }
            }
        }
        
        // Observe new messages in real-time from conversationRef2
        conversationRef2.observe(.childAdded) { snapshot in
            self.getAllMessagesForConversation(userUID: userUID, senderUID: senderUID) { result in
                switch result {
                case .success(let messages):
                    // Handle the updated messages array
                    print("New messages: \(messages)")
                case .failure(let error):
                    print("Failed to get new messages: \(error)")
                }
            }
        }
    }

    
    
    ///enviar msgm
    public func sendMessage(senderUID: String, message: Message, completion: @escaping (Bool) -> Void) {
        let databaseRef = Database.database().reference().child("Messages").child(message.sender.senderId).child(senderUID).child(message.messageId)
            
        let messageDate = message.sentDate
        let dateString = ConversaViewController.dateFormatter.string(from: messageDate)
        let messageTime = message.time
        let timeString = ConversaViewController.timeFormatter.string(from: messageTime)
        
        //no caso de vir a suportar mais tipos de msgms no futuro
        var msg = ""
        
        switch message.kind {
        case .text(let messageText):
            msg = messageText
        case .attributedText(_):
            break
        case .photo(_):
            break
        case .video(_):
            break
        case .location(_):
            break
        case .emoji(_):
            break
        case .audio(_):
            break
        case .contact(_):
            break
        case .linkPreview(_):
            break
        case .custom(_):
            break
        }
            
        let messageData: [String: Any] = [
            "date": dateString,
            "from": message.sender.senderId,
            "message": msg,
            "messageID": message.messageId,
            "time": timeString,
            "to": senderUID,
            "type": "text"
        ]
        
        databaseRef.setValue(messageData, withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        })
        
    }
    
    
    public func deleteConvo(uid: String, senderUID: String) {
        let databaseRef = Database.database().reference().child("Messages").child(uid).child(senderUID)
        databaseRef.removeValue()
    }
    
    func getLastMessage(userID: String, senderID: String, completion: @escaping (Result<String?, Error>) -> Void) {
        self.getAllMessagesForConversation(userUID: userID, senderUID: senderID, completion: {  result in
            switch result {
            case .success(let messages):
                guard !messages.isEmpty else {
                    return
                }
                var msgtxt = ""
                switch messages.last?.kind {
                case .text(let text):
                    msgtxt = text
                case .attributedText(_):
                    break
                case .photo, .video, .location, .emoji, .audio, .contact, .custom:
                    break
                case .none:
                    break
                case .some(.linkPreview(_)):
                    break
                }
                completion(.success(msgtxt))
            case .failure(let error):
                print("failed to get messages")
                completion(.failure(error))
            }
        })
    }

}
