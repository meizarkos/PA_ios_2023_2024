//
//  AppDelegate.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 24/04/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var token: String?
    
    func bootIpadApp(){
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabController = UITabBarController()
        
        let homeNav = UINavigationController(rootViewController: HomeViewController())
        
        tabController.viewControllers = [
            homeNav,
            AccueilViewController()
        ]
        
        window.rootViewController = tabController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.bootIpadApp()
        return true
    }


}

