//
//  PlaceholderView.swift
//  WeatherFinder
//
//  Created by Victor Pelivan on 27.10.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class PlaceholderView: UIView {
    
    @IBOutlet weak var placeholderImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var decsriptionLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        decsriptionLabel.isHidden = true
        retryButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
    }
    
    private func setupXib() {
        guard let viewFromXib = Bundle.main.loadNibNamed("PlaceholderView", owner: self, options: nil)?.first as? UIView  else {
            print("Unable to load view from xib in PlaceholderView class")
            return
        }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}
