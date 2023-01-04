//
//  SignUpViewController.swift
//  Chatting App
//
//  Created by ericzero on 12/16/22.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController {

    @IBOutlet var EmailTF: UITextField!{
        didSet{
            EmailTF.clipsToBounds = true
            EmailTF.layer.cornerRadius = EmailTF.frame.size.height / 2
        }
    }
    
    @IBOutlet var passwordTF: UITextField!{
        didSet{
            passwordTF.clipsToBounds = true
            passwordTF.layer.cornerRadius = passwordTF.frame.size.height / 2
        }
    }
    
    @IBOutlet var SignUpLabel: UIButton!{
        didSet{
            SignUpLabel.clipsToBounds = true
            SignUpLabel.layer.cornerRadius = SignUpLabel.frame.size.height / 2
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func SignUpTapped(_ sender: Any) {
        
        if let email = EmailTF.text, let password = passwordTF.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let vc = ChatViewController(nibName: "ChatViewController", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        let vc = SignInViewController()
        navigationController?.popViewController(animated: true)
    }
    
}
