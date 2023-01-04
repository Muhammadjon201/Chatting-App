//
//  ChatTableViewCell.swift
//  Chatting App
//
//  Created by ericzero on 12/18/22.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    @IBOutlet var ChatLabel: UILabel!
    
    @IBOutlet var ChatBackgroundView: UIView! {
        didSet{
            ChatBackgroundView.layer.cornerRadius = 15
            ChatBackgroundView.backgroundColor = UIColor(red: 233/255, green: 119/255, blue: 119/255, alpha: 1)
        }
    }
    
    @IBOutlet var ChatImageView: UIImageView!
    @IBOutlet var leftImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(data: Message) {
        ChatLabel.text = data.body
    }
    
}
