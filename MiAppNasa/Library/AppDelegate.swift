//
//  AppDelegate.swift
//  MiAppNasa
//
//  Created by Cinthia Villegas on 23/03/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupFirstView()
        setupNetworkMonitoring()
        return true
    }
    
    private func setupFirstView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    func setupNetworkMonitoring() {
        Network.shared.startObserver()
    }
}

