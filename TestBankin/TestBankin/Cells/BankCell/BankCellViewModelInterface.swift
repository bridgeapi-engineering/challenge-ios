//
//  BankCellViewModelInterface.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import UIKit

protocol BankCellViewModelInterface {
    var title: String { get }
    var color: UIColor { get }
    
    func getImage(onSuccess: @escaping (UIImage) -> (), onError: @escaping () -> Void)
}
