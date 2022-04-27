//
//  HomeViewController.swift
//  ChallengeiOS
//
//  Created by Etienne JEZEQUEL on 27/04/2022.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {

}

class HomeViewController: UIViewController {

    // MARK: - Public
    var viewModel: HomeViewModelProtocol!
    weak var delegate: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
