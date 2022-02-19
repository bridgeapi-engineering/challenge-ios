//
//  TableViewModelInterface.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import UIKit

typealias TableViewSectionName = String
typealias TableViewData = [TableViewSectionName: [TableViewCellType]]

protocol TableViewModelInterface {
    var title: String { get }

    func getData(onSuccess: @escaping (TableViewData) -> (), onError: @escaping (String) -> ())
    func setup(cell: UITableViewCell, with type: TableViewCellType)
}

enum TableViewCellType {
    case bankCell(BankCellViewModelInterface)

    var identifier: String {
        switch self {
            case .bankCell:
                return "BankCell"
        }
    }
}
