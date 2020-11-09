//
//  PlaceholderView.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 27.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

protocol PlaceholderViewDelegate: class {
    func placeholderButtonBeingTapped()
}

class PlaceholderView: UIView {

    @IBOutlet weak var placeholderImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var goToSettingsButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!

    weak var delegate: PlaceholderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func updatePlaceholderViewData(viewModel: SettingsPlaceholderViewModel) {
        titleLabel.text = viewModel.title.localized
        descriptionLabel.text = viewModel.description?.localized ?? "No Value".localized
        goToSettingsButton.setTitle(viewModel.button?.localized ?? "No Value".localized, for: .normal)
        placeholderImageView.image = viewModel.image ?? UIImage(named: "NoImage")
        switch viewModel.kind {
        case .loadingData:
            descriptionLabel.isHidden = true
        case .geolocationDenied:
            goToSettingsButton.isHidden = false
        case .noResults, .noInternet, .geolocationOff:
            break
        }
    }

    private func commonInit() {
        let viewFromXib = self.getViewFromXib(nibName: "PlaceholderView")
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        titleLabel.isHidden = false
        descriptionLabel.isHidden = false
        goToSettingsButton.isHidden = true
        setupButton()
    }

    private func setupButton() {
        goToSettingsButton.layer.borderWidth = 1
        goToSettingsButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        goToSettingsButton.layer.cornerRadius = 5
        goToSettingsButton.layer.shadowColor = #colorLiteral(red: 0.1968304687, green: 0.3024655521, blue: 0.5, alpha: 1)
        goToSettingsButton.layer.shadowOpacity = 1
        goToSettingsButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        goToSettingsButton.addTarget(self, action: #selector(tapGoToSettingsButton(_:)), for: .touchUpInside)
    }

    @objc private func tapGoToSettingsButton(_ sender: UIButton) {
        delegate?.placeholderButtonBeingTapped()
    }
}
