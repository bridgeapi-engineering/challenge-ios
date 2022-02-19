//
//  MainViewController.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import UIKit

class MainViewController: UIViewController {
    let tableView = UITableView()
    var tableViewSection = [String]()


    var viewModel: TableViewModelInterface? {
        didSet {
            viewModelDidSet()
        }
    }

    var tableViewData: TableViewData = [:] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        setupTableView()
    }

    func viewModelDidSet() {
        viewModel?.getData(onSuccess: { [weak self] tableViewData in
            DispatchQueue.main.async {
                self?.tableViewSection = tableViewData.keys.sorted()
                self?.tableViewData = tableViewData
            }
        }, onError: { errorMessage in

        })
    }
}

private extension MainViewController {
    func setupTableView() {
        tableView.register(BankCell.self, forCellReuseIdentifier: "BankCell")
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white

        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

extension MainViewController: UITableViewDelegate {

}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSection.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewSection[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableViewSection[section]

        return tableViewData[sectionData]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionIndex = indexPath.section
        let sectionData = tableViewSection[sectionIndex]

        guard let cellType = tableViewData[sectionData]?[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier) else {
            return UITableViewCell()
        }
        viewModel?.setup(cell: cell, with: cellType)
        
        return cell
    }
}
