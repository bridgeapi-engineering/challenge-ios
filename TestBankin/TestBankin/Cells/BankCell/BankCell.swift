//
//  BankCell.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import UIKit

class BankCell: UITableViewCell {
    let stackView = UIStackView()
    let logoImage = UIImageView()
    let titleLabel = UILabel()
    
    private var viewModel: BankCellViewModelInterface? {
        didSet {
            viewModelDidSet()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setContentView()
        setStackView()
        setImageView()
        stackView.addArrangedSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with viewModel: BankCellViewModelInterface) {
        self.viewModel = viewModel
    }

    private func viewModelDidSet() {
        updateContentViewBackground()
        updateLabelLayout()

        viewModel?.getImage(onSuccess: { [weak self] image in
            DispatchQueue.main.async {
                self?.updateLogoImage(with: image)
            }
        }, onError: {})
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = ""
        logoImage.image = nil
    }
}

private extension BankCell {
    func setContentView() {
        let constraints = [
            logoImage.heightAnchor.constraint(equalToConstant: 60)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setStackView() {
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10

        contentView.addSubview(stackView)
        let constraints = [
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            contentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func setImageView() {
        stackView.addArrangedSubview(logoImage)
        logoImage.contentMode = .scaleAspectFit

        let constraints = [
            logoImage.widthAnchor.constraint(equalToConstant: 40),
            logoImage.heightAnchor.constraint(equalToConstant: 40)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

private extension BankCell {
    func updateLogoImage(with image: UIImage?) {
        logoImage.image = image
    }

    func updateLabelLayout() {
        guard let viewModel = viewModel else { return }

        titleLabel.text = viewModel.title
        titleLabel.textColor = (contentView.backgroundColor?.isDark() ?? false) ? .white : .black
    }

    func updateContentViewBackground() {
        guard let viewModel = viewModel else { return }

        contentView.backgroundColor = viewModel.color
    }
}
