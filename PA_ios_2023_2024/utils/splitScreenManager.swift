//
//  splitScreenManager.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 13/06/2024.
//

import Foundation
import UIKit

func createVC(goTo:UIViewController,actu:UIViewController){
    let splitVC = UISplitViewController()
    
    splitVC.viewControllers = [goTo,UIViewController()]
    
    let tabBarControl = UITabBarController()

    tabBarControl.viewControllers = [
        splitVC,
    ]
    
    //tabBarControl.navigationItem.hidesBackButton = true
    
    actu.navigationController?.pushViewController(tabBarControl, animated: true)
}


func createTwoScreensVC(goTo:UIViewController,secondGoTo:UIViewController, actu:UIViewController){
    let splitVC = UISplitViewController()
    
    splitVC.viewControllers = [goTo,secondGoTo]
    
    let tabBarControl = UITabBarController()

    tabBarControl.viewControllers = [
        splitVC,
    ]
    
    //tabBarControl.navigationItem.hidesBackButton = true
    
    actu.navigationController?.pushViewController(tabBarControl, animated: true)
}


func reloadVC(next:UIViewController,actu:UIViewController){
    if actu.splitViewController != nil {
        actu.splitViewController!.viewControllers[1] = next
    }
    else if actu.navigationController != nil {
        actu.navigationController?.pushViewController(next, animated: true)
    }
}
