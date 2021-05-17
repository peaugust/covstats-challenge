//
//  ReportsRepository.swift
//  cov-stats
//
//  Created by Pedro Freddi on 11/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import Foundation
import RxSwift

class ReportsRepository {
    var stats = BehaviorSubject<StatsReports?>(value: nil)
    var casesByCountry = BehaviorSubject<[CountryReport]>(value: [])
    var fetchReportsError = BehaviorSubject<String?>(value: nil)
    
    
    func fetchReports() {
        ReportsAPIManager.GetReports().request { result in
            switch result {
            case .failure(let error):
                self.fetchReportsError.onNext(error.localizedDescription)
            case .success(let response):
                self.stats.onNext(response.stats)
                self.casesByCountry.onNext(response.casesByCountry)
            }
        }
    }
}
