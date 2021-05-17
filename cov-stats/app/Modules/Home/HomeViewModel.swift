//
//  HomeViewModel.swift
//  cov-stats
//
//  Created by Pedro Freddi on 11/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    init(reportsRepository: ReportsRepository) {
        self.reportsRepository = reportsRepository
        reportsRepository.stats.subscribe(onNext: {[weak self] stats in
            self?.stats.onNext(stats)
        }).disposed(by: disposeBag)
        reportsRepository.casesByCountry.subscribe(onNext: {[weak self] casesByCountry in
            self?.casesByCountry.onNext(casesByCountry)
        }).disposed(by: disposeBag)
        reportsRepository.fetchReportsError.subscribe(onNext: {[weak self] error in
            self?.fetchReportsError.onNext(error)
        }).disposed(by: disposeBag)
        self.fetchReports()
    }
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    var reportsRepository: ReportsRepository
    var stats = BehaviorSubject<StatsReports?>(value: nil)
    var casesByCountry = BehaviorSubject<[CountryReport]>(value: [])
    var fetchReportsError = BehaviorSubject<String?>(value: nil)
    
    // MARK: - Private

    private func fetchReports() {
        reportsRepository.fetchReports()
    }
}
