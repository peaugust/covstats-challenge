//
//  HomeViewController.swift
//  cov-stats
//
//  Created by Pedro Freddi on 06/05/21.
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
        totalCasesView.valueLabel.textColor = UIColor.black
        recoveredView.titleLabel.text = "Recovered"
        recoveredView.valueLabel.text = "100.000"
        recoveredView.valueLabel.textColor = UIColor.green
        activeCasesView.titleLabel.text = "Active Cases"
        activeCasesView.valueLabel.text = "100.000"
        activeCasesView.valueLabel.textColor = UIColor.black
        totalDeathView.titleLabel.text = "Total Death"
        totalDeathView.valueLabel.text = "100.000"
        totalDeathView.valueLabel.textColor = UIColor.brandColor
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(CountryCell.self)
        tableView.layer.borderColor = UIColor.gray60.cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CountryCell
        cell.bind(countryCode: "BR", countryName: "Brazil", countryReports: "123.456")
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return LiveReportsHeader()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
}
