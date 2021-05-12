//
//  Reports.swift
//  cov-stats
//
//  Created by Pedro Freddi on 11/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import Foundation

struct StatsReports: Codable {
    let totalCases: String
    let recoveredCases: String
    let activeCases: String
    let totalDeath: String
}

struct LiveReports: Codable {
    let allReports: [CountryReport]
}

struct CountryReport: Codable {
    let code: String
    let name: String
    let numberOfCases: String
}
