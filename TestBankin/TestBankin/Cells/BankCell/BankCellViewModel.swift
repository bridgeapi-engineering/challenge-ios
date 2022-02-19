//
//  BankCellViewModel.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import UIKit

class BankCellViewModel: BankCellViewModelInterface {
    let title: String
    let color: UIColor

    private let imageUrl: String?

    init(with bank: Bank) {
        title = bank.name
        color = UIColor(hex: bank.primaryColor ?? "") ?? .white
        imageUrl = bank.logoUrl
    }

    func getImage(onSuccess: @escaping (UIImage) -> (), onError: @escaping () -> Void) {
        guard let urlString = imageUrl,
              let url = URL(string: urlString) else {
            onError()
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil ,
                  let data = data,
                  let image = UIImage(data: data) else {
                onError()
                return
            }


            onSuccess(image)
        }).resume()
    }
}
