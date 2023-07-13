//
//  ChatViewController.swift
//  ProjetoRegula3.0
//

import UIKit
import JGProgressHUD

struct Conversation {
    let userUID: String
    let senderUID: String
    let senderName: String
    let lastMessage: String
}

class ChatViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private var conversations = [Conversation]()
    
    var chatManager = ChatManager()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true   //nao mostra tabela se não tiver conversas
        table.register(ConversaTableViewCell.self, forCellReuseIdentifier: ConversaTableViewCell.identifier)
        return table
    }()
    
    private let noConversationsLable: UILabel = {
        let lable = UILabel()
        lable.text = "Sem conversas"
        lable.textAlignment = .center
        lable.textColor = .gray
        lable.font = .systemFont(ofSize: 21, weight: .medium)
        lable.isHidden = true
        return lable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(didTapComposeButton))
        view.addSubview(tableView)
        view.addSubview(noConversationsLable)
        setupTableView()
        fetchConversations()
        startListeningForConversations()
        print("im in chat screen")
    }
    
    private func startListeningForConversations() {
        guard let uid = UserDefaults.standard.value(forKey: "uid") as? String else {
            return
        }
        chatManager.getAllConversations(for: uid, completion: { [weak self] result in
            switch result {
            case .success(let conversations):
                guard !conversations.isEmpty else {
                    return
                }
                self?.conversations = conversations
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("failed to get convos")
            }
        })
    }
    
    @objc private func didTapComposeButton(){
        let vc = NovaConversaViewController()
        vc.completion = { [weak self] result in
            //print("\(result)") debug
            self?.createNewConversation(result: result)
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func createNewConversation(result: [String: String]) {
        guard let name = result["name"], let uid = result["uid"] else {
            return
        }
        let vc = ConversaViewController(with: uid)
        vc.isNewConversation = true
        vc.title = name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchConversations(){
        tableView.isHidden = false
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let model = conversations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversaTableViewCell.identifier,
                                                 for: indexPath) as! ConversaTableViewCell
        cell.configure(with: model)
        return cell
    }
    
    //para abrir a conversa quando se clica num elemento da lista
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let model = conversations[indexPath.row]
        
        let vc = ConversaViewController(with: model.senderUID)
        vc.title = model.senderName
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

