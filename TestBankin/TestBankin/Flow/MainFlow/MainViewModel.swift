//
//  MainViewModel.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import UIKit

typealias Banks = [Bank]

struct MainViewModelInput {
    let service: Service
}

class MainViewModel: TableViewModelInterface {
    let service: Service?
    let title = "Liste des banques"

    var input: MainViewModelInput? {
        didSet {
            inputDidSet()
        }
    }

    init(with input: MainViewModelInput) {
        service = input.service
        defer {
            self.input = input
        }
    }

    func getData(onSuccess: @escaping (TableViewData) -> (), onError: @escaping (String) -> ()) {
        fetchBanks { [weak self] banks in
            onSuccess(self?.handleFetchBanksResponse(banks) ?? [:])
        } onError: { errorMessage in
            onError(errorMessage)
        }

    }
}

extension MainViewModel {
    func setup(cell: UITableViewCell, with type: TableViewCellType) {
        switch type {
            case .bankCell(let viewModel): (cell as? BankCell)?.setup(with: viewModel)
        }
    }
}

private extension MainViewModel {
    func inputDidSet() {

    }

    func fetchBanks(onSuccess: @escaping (Banks) -> (), onError: @escaping (String) -> ()) {
        service?.getBanks(result: { result in
            switch result {
                case .success(let response):
                    onSuccess(response.resources)
                case .failure(let error):
                    onError(error.localizedDescription)
            }
        })
    }

    func handleFetchBanksResponse(_ banks: Banks) -> TableViewData {
        var tableViewData: TableViewData = [:]
        for bank in banks {
            var currentBanksForCountryCode = tableViewData[bank.countryCode] ?? []
            let viewModel = BankCellViewModel(with: bank)
            currentBanksForCountryCode.append(.bankCell(viewModel))

            tableViewData[bank.countryCode] = currentBanksForCountryCode
        }

        return tableViewData
    }
}
