//
//  AppDelegate.swift
//  ChallengeiOS
//
//  Created by Etienne JEZEQUEL on 27/04/2022.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    private let container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()

        if let rootViewController = window?.rootViewController as? UINavigationController {
            rootViewController.isNavigationBarHidden = true
            appCoordinator = AppCoordinator(navigationController: rootViewController,
                                            container: container)
        }

        // Start Coordinator
        appCoordinator?.start()

        window?.makeKeyAndVisible()
        return true
    }
}
