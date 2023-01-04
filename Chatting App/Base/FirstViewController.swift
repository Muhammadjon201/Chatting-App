//
//  FirstViewController.swift
//  MyTwitter
//
//  Created by ericzero on 12/16/22.
//

import UIKit
import Firebase

class FirstViewController: UIViewController {
    
    @IBOutlet var RegisterLabel: UIButton!{
        didSet{
            RegisterLabel.clipsToBounds = true
            RegisterLabel.layer.cornerRadius = RegisterLabel.frame.size.height / 2
        }
    }
    
    
    @IBOutlet var SignInLabel: UIButton!{
        didSet{
            SignInLabel.clipsToBounds = true
            SignInLabel.layer.cornerRadius = SignInLabel.frame.size.height / 2
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

    @IBAction func RegisterTapped(_ sender: Any) {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func SignInTapped(_ sender: Any) {
        let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
