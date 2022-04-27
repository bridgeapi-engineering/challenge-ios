//
//  Coordinator.swift
//  ChallengeiOS
//
//  Created by Etienne JEZEQUEL on 27/04/2022.
//

import Swinject

protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }
    var finishFlow: Closure? { get set }
    init(navigationController: UINavigationController, container: Container)
    func start()
    func triger(route: Route)
}

// To make the function optional
extension Coordinator {
    func triger(route: Route) { }
}
