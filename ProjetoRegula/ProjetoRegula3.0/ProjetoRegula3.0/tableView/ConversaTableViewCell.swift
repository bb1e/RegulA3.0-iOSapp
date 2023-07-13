//
//  ConversaTableViewCell.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 10/07/2023.
//

import UIKit

class ConversaTableViewCell: UITableViewCell {
    
    static let identifier = "ConversaTableViewCell"
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.circle")
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()
    
    ///para meter a ultima mgm do user
    private let userMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userMessageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        userNameLabel.frame = CGRect(x: userImageView.right + 10,
                                     y: 10,
                                     width: contentView.width - 20 - userImageView.width,
                                     height: (contentView.height - 20)/2)
        userMessageLabel.frame = CGRect(x: userImageView.right + 10,
                                       y: userNameLabel.bottom + 10,
                                       width: contentView.width - 20 - userImageView.width,
                                       height: (contentView.height - 20)/2)
    }
    
    public func configure(with model: Conversation) {
        self.userNameLabel.text = model.senderName
        self.userImageView.image = UIImage(systemName: "person.circle")
        self.userMessageLabel.text = model.lastMessage
    }
    

}
