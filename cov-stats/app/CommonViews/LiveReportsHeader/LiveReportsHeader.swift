//
//  LiveReportsHeader.swift
//  cov-stats
//
//  Created by Pedro Freddi on 06/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import UIKit

final class LiveReportsHeader: UIView, NibLoadable {

    // MARK: - IBOutlets

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
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
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.text = "Live Reports"
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .gray3
        subtitleLabel.text = "Top five countries"
    }
}

