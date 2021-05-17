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

    static func initModule(viewModel: HomeViewModel) -> HomeViewController {
        let viewController = loadFromStoryboard()
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - IBOutlets
    @IBOutlet var totalCasesView: StatView!
    @IBOutlet var recoveredView: StatView!
    @IBOutlet var activeCasesView: StatView!
    @IBOutlet var totalDeathView: StatView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!

    // MARK: - Properties
    private let tableViewHeaderHeight: CGFloat = 72.0
    private let notAvailableText = "N/A"
    private var viewModel: HomeViewModel?
    private var dataSource: [CountryReport] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatViews()
        setupTableView()
        setupObservables()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.title = "COVID-19"
    }

    // MARK: - Private
    
    private func setupObservables() {
        viewModel?.casesByCountry.subscribe(onNext: { [weak self] casesByCountry in
            guard let self = self else { return }
            self.dataSource = casesByCountry
            self.tableViewHeight.constant = CGFloat(96 * casesByCountry.count) + self.tableViewHeaderHeight
        }).disposed(by: disposeBag)
        
        viewModel?.stats.subscribe(onNext: { [weak self] stats in
            guard let self = self else { return }
            self.totalCasesView.setValue(value: stats?.totalCases ?? self.notAvailableText)
            self.recoveredView.setValue(value: stats?.recoveredCases ?? self.notAvailableText, withColor: .green)
            self.activeCasesView.setValue(value: stats?.activeCases ?? self.notAvailableText)
            self.totalDeathView.setValue(value: stats?.deathCases ?? self.notAvailableText, withColor: .brandColor)
        }).disposed(by: disposeBag)
    }

    private func setupStatViews() {
        totalCasesView.setTitle(title: "Total Cases")
        recoveredView.setTitle(title: "Recovered")
        activeCasesView.setTitle(title: "Active Cases")
        totalDeathView.setTitle(title: "Total Death")
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
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CountryCell
        let report = dataSource[indexPath.row]
        cell.bind(countryCode: report.code, countryName: report.name, countryReports: report.cases)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return LiveReportsHeader()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHeaderHeight
    }
}
