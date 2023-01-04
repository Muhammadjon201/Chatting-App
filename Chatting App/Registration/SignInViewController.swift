//
//  SignInViewController.swift
//  Chatting App
//
//  Created by ericzero on 12/16/22.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet var signInEmailTF: UITextField!{
        didSet{
            signInEmailTF.clipsToBounds = true
            signInEmailTF.layer.cornerRadius = signInEmailTF.frame.size.height / 2
        }
    }
    
    @IBOutlet var SignInPasswordTF: UITextField!{
        didSet{
            SignInPasswordTF.clipsToBounds = true
            SignInPasswordTF.layer.cornerRadius = SignInPasswordTF.frame.size.height / 2
        }
    }
    
    @IBOutlet var LoginLabel: UIButton!{
        didSet{
            LoginLabel.clipsToBounds = true
            LoginLabel.layer.cornerRadius = LoginLabel.frame.size.height / 2
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
        view.backgroundColor = .white
        
    }

    @IBAction func RegisterTapped(_ sender: Any) {
        if let email = signInEmailTF.text, let password = SignInPasswordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    let vc = ChatViewController(nibName: "ChatViewController", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
            
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
