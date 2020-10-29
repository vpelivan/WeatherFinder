//
//  PlaceholderView.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 27.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

protocol PlaceholderViewDelegate {
    func onButtonTapped()
}

class PlaceholderView: UIView {
    
    @IBOutlet weak var placeholderImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var goToSettingsButton: UIButton!
    
    var delegate: PlaceholderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func updatePlaceholderViewData(_ headerText: String?,
                                   _ descriptionText: String? = nil,
                                   _ settingsButtonLabel: String? = nil,
                                   _ image: UIImage? = nil) {
        headerLabel.text = headerText?.localized ?? "No Value".localized
        descriptionLabel.text = descriptionText?.localized ?? "No Value".localized
        goToSettingsButton.setTitle(settingsButtonLabel?.localized ?? "No Value".localized, for: .normal)
        placeholderImageView.image = (image != nil ? image : UIImage(named: "NoImage"))
    }
    
    private func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("PlaceholderView", owner: self, options: nil)?.first as? UIView  else {
            print("Unable to load view from xib in PlaceholderView class")
            return
        }
        
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        headerLabel.isHidden = false
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
        goToSettingsButton.addTarget(self, action: #selector(tapRetryButton(_:)), for: .touchUpInside)
    }
    
    @objc private func tapRetryButton(_ sender: UIButton) {
        delegate?.onButtonTapped()
    }
}
