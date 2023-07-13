//
//  ConversaViewController.swift
//  ProjetoRegula3.0
//

import Foundation
import UIKit
import MessageKit
import InputBarAccessoryView
import CryptoKit

struct Message: MessageType {
    public var sender: SenderType
    public var messageId: String
    public var sentDate: Date
    public var kind: MessageKind
    public var time: Date
}

struct Sender: SenderType {
    public var senderId: String
    public var displayName: String
}

class ConversaViewController: MessagesViewController {
    
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        
        return formatter
    }()
    
    public static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        return formatter
    }()
    
    public let otherUserId: String
    public var isNewConversation = false
    
    var chatManager = ChatManager()
    
    private var messages = [Message]() //array das msgns
    
    private var selfSender: Sender? {
        guard let uid = UserDefaults.standard.value(forKey: "uid") as? String else {
            return nil
        }
        return Sender(senderId: uid as String,
               displayName: "Me")
               //displayName: UserDefaults.standard.value(forKey: "name") as! String)
    }
    
    private func listenForMessages(userUID: String, senderUID: String, shouldScrollToBottom: Bool){
        chatManager.getAllMessagesForConversation(userUID: selfSender!.senderId, senderUID: otherUserId, completion: { [weak self] result in
            switch result {
            case .success(let messages):
                guard !messages.isEmpty else {
                    return
                }
                self?.messages = messages
                DispatchQueue.main.async {
                    self?.messagesCollectionView.reloadDataAndKeepOffset()
                    
                    if shouldScrollToBottom {
                        self?.messagesCollectionView.scrollToLastItem()
                    }
                }
            case .failure(let error):
                print("failed to get messages")
            }
        })
    }
    
    //uma conversa = userUID + senderUID
    init(with uid: String) {
        self.otherUserId = uid
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        //print(UserDefaults.standard.string(forKey: "uid"))
        //print(UserDefaults.standard.string(forKey: "name"))
        //chatManager.deleteConvo(uid: selfSender!.senderId, senderUID: otherUserId)
        //chatManager.observeNewMessages(userUID: selfSender!.senderId, senderUID: otherUserId)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
        listenForMessages(userUID: selfSender!.senderId, senderUID: otherUserId, shouldScrollToBottom: true)
    }


}

extension ConversaViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        //validar se não está vazio ou tem só espaços
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty,
        let selfSender = self.selfSender,
        let messageId = createMessageId() else {
            return
        }
        print("Sending: \(text)")
        //enviar a mensagem
        let message = Message(sender: selfSender, messageId: messageId, sentDate: Date(), kind: .text(text), time: Date())
            chatManager.sendMessage(senderUID: otherUserId, message: message, completion: {  success in
                if success {
                    print("message sent")
                    self.listenForMessages(userUID: selfSender.senderId, senderUID: self.otherUserId, shouldScrollToBottom: true)
                }
                else {
                    print("failed to sent")
                }
            })
    
    }
    
    private func createMessageId() -> String? {
        let length = 28
        
        let timestamp = Date().timeIntervalSince1970
        let seed = UInt64(timestamp)
        
        var rng = SystemRandomNumberGenerator()
        let randomData = Data((0..<length).map { _ in rng.next() })
        
        let hashData = SHA256.hash(data: randomData + withUnsafeBytes(of: seed) { Data($0) })
        let hashString = hashData.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashString
    }
    
}

extension ConversaViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    //saber quem é o sender atual - serve para a orientação dos balões de chat
    var currentSender: MessageKit.SenderType {
        if let sender = selfSender {
            return sender
        }
        fatalError("selfSender is null, uid should be cashed")
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section] //o msgkit usa section para separar as msgns
    }
    
}
