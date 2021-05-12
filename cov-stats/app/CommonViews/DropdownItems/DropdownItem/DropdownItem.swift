//
//  DropdownItem.swift
//  cov-stats
//
//  Created by Pedro Freddi on 11/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import UIKit

class DropdownItem: UITableViewCell, NibLoadable {

    // MARK: - IBOutlets

    @IBOutlet private var descriptionLabel: UILabel!

    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    // MARK: - Public

    func bind(withDescription description: String) {
        descriptionLabel.text = description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            descriptionLabel.textColor = .brandColor
        } else {
            descriptionLabel.textColor = .gray40
        }
    }

    // MARK: - Private

    private func setupView() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        descriptionLabel.textColor = .gray40
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        selectionStyle = .none
    }
}
