//
//  AppDelegate.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
  
    let navController = UINavigationController(rootViewController: HomeViewController())
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.\
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .mWhite()
            navController.navigationBar.isTranslucent = false
            navController.navigationBar.standardAppearance = appearance
            navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        } else {
            navController.navigationBar.isTranslucent = false
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        }
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let api = API()
        self.window?.rootViewController = UINavigationController(rootViewController: HomeViewController(api: api))
        self.window?.makeKeyAndVisible()

        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        DataBaseController.saveContext()
    }
}
