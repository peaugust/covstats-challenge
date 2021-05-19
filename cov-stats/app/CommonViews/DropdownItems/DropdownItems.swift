//
//  DropdownItems.swift
//  cov-stats
//
//  Created by Pedro Freddi on 11/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import UIKit

final class DropdownItems: UIView, NibLoadable {

    // MARK: - IBOutlets

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var tableView: UITableView!

    // MARK: - Properties
    
    private let items = [
        "Discover by City / Country",
        "Discover by Reported Cases",
        "Discover by Reported Deaths"
    ]
    
    var onSelectItem: ((String) -> Void)?

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
        setupView()
        setupTableView()
    }

    // MARK: - Private
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 51
        tableView.register(DropdownItem.self)
        tableView.layer.cornerRadius = 5
        tableView.separatorColor = UIColor.gray60.withAlphaComponent(0.6)
        tableView.isScrollEnabled = false
    }
    
    private func setupView() {
        backgroundView.layer.cornerRadius = 5
    }
}

extension DropdownItems: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectItem?(items[indexPath.row])
    }
}

extension DropdownItems: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as DropdownItem
        cell.bind(withDescription: items[indexPath.row])
        return cell
    }
}
