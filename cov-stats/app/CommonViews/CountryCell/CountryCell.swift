//
//  CountryCell.swift
//  cov-stats
//
//  Created by Pedro Freddi on 06/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import UIKit
import FlagKit

class CountryCell: UITableViewCell, NibLoadable {

    // MARK: - IBOutlets

    @IBOutlet private var cellBackgroundView: UIView!
    @IBOutlet private var countryFlagImage: UIImageView!
    @IBOutlet private var countryNameLabel: UILabel!
    @IBOutlet private var countryReportsLabel: UILabel!
    
    // MARK: - Properties

    private let borderWidth: CGFloat = 1
    private let borderCornerRadius: CGFloat = 10

    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    // MARK: - Public
    
    func bind(countryCode: String, countryName: String, countryReports: String) {
        let flag = Flag(countryCode: countryCode)
        countryFlagImage.image = flag?.image(style: .roundedRect)
        countryNameLabel.text = countryName
        countryReportsLabel.text = countryReports
    }

    // MARK: - Private

    private func setupView() {
        self.selectionStyle = .none
        
        cellBackgroundView.layer.borderColor = UIColor.gray60.cgColor
        cellBackgroundView.layer.borderWidth = borderWidth
        cellBackgroundView.layer.cornerRadius = borderCornerRadius
        
        countryNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .light)
        countryNameLabel.textColor = .black
        
        countryReportsLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        countryReportsLabel.textColor = .black
    }
}
