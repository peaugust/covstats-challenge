//
//  StatView.swift
//  cov-stats
//
//  Created by Pedro Freddi on 05/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import UIKit

final class StatView: UIView, NibLoadable {

    // MARK: - IBOutlets

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var labelsStackView: UIStackView!
    @IBOutlet var backgroundView: UIView!
    
    // MARK: - Properties

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupNibContent()
        setupBackgroundView()
        setupLabels()
    }

    // MARK: - Private

    private func setupBackgroundView() {
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.borderColor = UIColor.gray60.cgColor
        backgroundView.layer.borderWidth = 1
    }
    
    private func setupLabels() {
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .gray3
        valueLabel.font = UIFont.systemFont(ofSize: 26, weight: .medium)
    }
}

