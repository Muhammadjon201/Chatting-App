//
//  AppDelegate.swift
// Chatting App
//
//  Created by ericzero on 12/15/22.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        let vc = FirstViewController(nibName: "FirstViewController", bundle: nil)
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        navBar()
        
        // This is initial code for firebase setup..
        FirebaseApp.configure()
        
        // This is a code for initialize Firestore database..
        let db = Firestore.firestore()
        print(db)
        
        // IQKeyboardManager stuff..
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        return true
    }
    
    func navBar() {
        let color = UIColor(red: 233/255, green: 119/255, blue: 119/255, alpha: 1)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false

    }



}

