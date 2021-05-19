//
//  CasesRepository.swift
//  cov-stats
//
//  Created by Pedro Freddi on 11/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import Foundation
import RxSwift

class CasesRepository {
    var casesAroundSubject = BehaviorSubject<Int>(value: 0)

    func getCasesAround() {
        CasesAPIManager.GetCasesAround().request { result in
            switch result {
            case .failure(let error):
                self.casesAroundSubject.onError(error)
            case .success(let response):
                self.casesAroundSubject.onNext(response.casesAround)
            }
        }
    }
}

