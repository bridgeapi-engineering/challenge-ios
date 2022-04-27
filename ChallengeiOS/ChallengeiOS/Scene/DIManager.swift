//
//  DIManager.swift
//  ChallengeiOS
//
//  Created by Etienne JEZEQUEL on 27/04/2022.
//

import Swinject

/// Dependency Injection Manager.
/// Inject all the services, VM, VC needed by his `Coordinator`
class DIManager {

    private var container: Container

    init(container: Container) {
        self.container = container
        registerServices()
        registerViewModels()
        registerViewController()
    }

    /// Register Services into DI Container
    private func registerServices() {

    }

    /// Register View Models into DI Container
    private func registerViewModels() {
        container.register(HomeViewModelProtocol.self) { _ in
            HomeViewModel()
        }
    }

    /// Register View controller into DI Container
    private func registerViewController() {
        container.register(HomeViewController.self) { resolver in
            let controller = StoryboardScene.Home.initialScene.instantiate()
            if let viewModel = resolver.resolve(HomeViewModelProtocol.self) {
                controller.viewModel = viewModel
            }
            return controller
        }
    }

    func controller(for route: AppRoute) -> UIViewController? {
        switch route {
        case .home:
            return container.resolve(HomeViewController.self)
        }
    }
}
