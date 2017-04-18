//
//  MyCell.swift
//  Client_test
//
//  Created by Hirano on 2017/04/02.
//  Copyright © 2017年 Oyama. All rights reserved.
//

import UIKit
import SnapKit

// チャット画面のCell
class ChatCell: UITableViewCell {
    
    static let inset: CGFloat = 10.0
    static let nameHeight: CGFloat = 20.0
    
    let messageLabel: PaddingLabel = {
        let messageLabel = PaddingLabel(frame: CGRect.zero)
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = UIColor.green
        messageLabel.layer.masksToBounds = true
        messageLabel.layer.cornerRadius = 10.0
        messageLabel.textAlignment = NSTextAlignment.center
        return messageLabel
    }()
    let nameLabel: PaddingLabel = {
        let nameLabel = PaddingLabel(frame: CGRect.zero)
        nameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    var object: ChatCellValue? {
        didSet {
            self.messageLabel.attributedText = object?.attributedString(sentence: (object?.messageLog)!, fontSize: 14.0)
            self.messageLabel.sizeToFit()
            self.nameLabel.text = self.object?.userName
            self.nameLabel.sizeToFit()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        // cellの初期スタイル
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(messageLabel)
        self.addSubview(nameLabel)
        
        self.backgroundColor = Color.clearBlue
        self.layoutMargins = UIEdgeInsets.zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}