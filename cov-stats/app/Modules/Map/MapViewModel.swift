//
//  MapViewModel.swift
//  cov-stats
//
//  Created by Pedro Freddi on 11/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import Foundation
import RxSwift

class MapViewModel {
    init(repository: CasesRepository) {
        self.repository = repository
        self.casesAroundSubject = repository.casesAroundSubject
        self.getCasesAround()
        self.setFilter()
    }

    // MARK: - Properties

    var casesAroundSubject: BehaviorSubject<Int>
    var selectedFilterSubject = BehaviorSubject<String?>(value: nil)
    private var repository: CasesRepository

    func setFilter(filter: String = "Discover Corona Virus by") {
        selectedFilterSubject.onNext(filter)
    }

    // MARK: - Private

    private func getCasesAround() {
        repository.getCasesAround()
    }
}
