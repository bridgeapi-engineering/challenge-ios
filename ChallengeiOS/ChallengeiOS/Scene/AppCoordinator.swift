//
//  AppCoordinator.swift
//  ChallengeiOS
//
//  Created by Etienne JEZEQUEL on 27/04/2022.
//

import UIKit
import Swinject

enum AppRoute: Route {
    case home
}

/// AppCoordinator manage the navigation in the application
class AppCoordinator: NSObject, Coordinator {

    var childCoordinators: [Coordinator] = []
    var finishFlow: Closure?
    private var container: Container
    private var diManager: DIManager
    private let navigationController: UINavigationController

    required init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
        diManager = DIManager(container: container)
    }

    func start() {
        triger(route: .home)
    }

    /// Rooting, root to the given parameter
    /// - Parameter route: route to go
    func triger(route: AppRoute) {
        let controller = diManager.controller(for: route)

        switch route {
        case .home:
            guard let controller = controller as? HomeViewController else { return }
            controller.delegate = self
            navigationController.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - HomeViewControllerDelegateß
extension AppCoordinator: HomeViewControllerDelegate {

}
