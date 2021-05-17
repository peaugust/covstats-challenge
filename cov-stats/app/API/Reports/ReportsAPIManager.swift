//
//  ReportsAPIManager.swift
//  cov-stats
//
//  Created by Pedro Freddi on 11/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import Foundation
import Alamofire

final class ReportsAPIManager {
    struct GetReports: APIRequestable {
        typealias APIResponse = ResponseBody
        var method: HTTPMethod = .get
        var parameters: Parameters?
        var url: String = Constants.Endpoints.latestData
        var headers: HTTPHeaders?
        var logoutIfUnauthorized: Bool = false
        var apiLoggerLevel: APILoggerLevel = .debug
        
        struct ResponseBody: Codable {
            let stats: StatsReports
            let casesByCountry: [CountryReport]
        }
    }
}
