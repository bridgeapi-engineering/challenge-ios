//
//  ApplicationCoordinator.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import Foundation
import UIKit

class ApplicationCoordinator {
    var window: UIWindow
    let service: Service

    var router: UINavigationController? {
        return window.rootViewController as? UINavigationController
    }

    init(with window: UIWindow) {
        self.window = window
        service = Service()
    }

    func start() {
        runMainFlow()
    }
}

private extension ApplicationCoordinator {
    func runMainFlow() {
        let mainController = MainViewController()
        mainController.viewModel = MainViewModel(with: MainViewModelInput(service: service))
        window.rootViewController = UINavigationController(rootViewController: mainController)
        self.window.makeKeyAndVisible()
    }
}
