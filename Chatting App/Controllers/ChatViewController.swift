//
//  ChatViewController.swift
//  Chatting App
//
//  Created by ericzero on 12/18/22.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet var BottomView: UIView! {
        didSet{
            BottomView.backgroundColor = UIColor(red: 233/255, green: 119/255, blue: 119/255, alpha: 1)
        }
    }
    @IBOutlet var MessageTF: UITextField!{
        didSet{
            MessageTF.clipsToBounds = true
            MessageTF.layer.cornerRadius = MessageTF.frame.size.height / 2
        }
    }
    @IBOutlet var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableViewSettings()
        navigationSettings()
        loadMessages()

    }
    
    // tableView config..
    func tableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.separatorStyle = .none
    }
    
    // navigation settings..
    func navigationSettings() {
        title = "Chat"
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
    }
    // Retrieving data..
    func loadMessages() {
        
        db.collection(Fstore.collectionName).order(by: Fstore.dateField).addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            if let e = error {
                print("There is an error retrieving data from firestore \(e)")
            }else {
                if let snapshopDocuments = querySnapshot?.documents {
                    for doc in snapshopDocuments {
                        let data = doc.data()
                        if let messageSender = data[Fstore.senderField] as? String, let messageBody = data[Fstore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func logoutTapped() {
        let firebaseAuth = Auth.auth()
        do {
        try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
        print("Error signing out: %@", signOutError)
       }
      
    }
    
    // Saving data..
    @IBAction func sendPressed(_ sender: Any) {
        if let messageBody = MessageTF.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Fstore.collectionName).addDocument(data: [
                Fstore.senderField: messageSender,
                Fstore.bodyField: messageBody,
                Fstore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("There was an issue with \(e)")
                } else {
                    print("Successfullu saved data")
                    DispatchQueue.main.async {
                        self.MessageTF.text = ""
                    }
                }
            }
        }
    }
    
}

// MARK: TableView extension

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        
        let message = messages[indexPath.row]
        
        cell.updateCell(data: message)
        
        // This line for message for current message sender..
        if message.sender == Auth.auth().currentUser?.email {
            cell.ChatImageView.isHidden = false
            cell.leftImageView.isHidden = true
            cell.ChatBackgroundView.backgroundColor = UIColor(red: 233/255, green: 119/255, blue: 119/255, alpha: 1)
            cell.ChatLabel.textColor = .black
        }
        // This is message from another sender...
        else {
            cell.ChatImageView.isHidden = true
            cell.leftImageView.isHidden = false
            cell.ChatBackgroundView.backgroundColor = .black
            cell.ChatLabel.textColor = .white
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - TextField Delegate methods..
extension ChatViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        MessageTF.text = ""
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        
        return true
    }
    
}
