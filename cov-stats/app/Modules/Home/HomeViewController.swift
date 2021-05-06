//
//  HomeViewController.swift
//  cov-stats
//
//  Created by Pedro Freddi on 05/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, StoryboardLoadable {

    // MARK: - Factory

    static func initModule() -> HomeViewController {
        let viewController = loadFromStoryboard()
        return viewController
    }

    // MARK: - IBOutlets
    @IBOutlet var totalCasesView: StatView!
    @IBOutlet var recoveredView: StatView!
    @IBOutlet var activeCasesView: StatView!
    @IBOutlet var totalDeathView: StatView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewBackground: UIView!
    
    
    // MARK: - Properties

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatViews()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Private

    private func setupStatViews() {
        totalCasesView.titleLabel.text = "Total Cases"
        totalCasesView.valueLabel.text = "100.000"
        recoveredView.titleLabel.text = "Recovered"
        recoveredView.valueLabel.text = "100.000"
        activeCasesView.titleLabel.text = "Active Cases"
        activeCasesView.valueLabel.text = "100.000"
        totalDeathView.titleLabel.text = "Total Death"
        totalDeathView.valueLabel.text = "100.000"
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.separatorStyle = .none
//        TODO: Add a custom view here
//        tableView.register()
        tableViewBackground.layer.borderColor = UIColor.gray60.cgColor
        tableViewBackground.layer.borderWidth = 1
        tableViewBackground.layer.cornerRadius = 10
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
