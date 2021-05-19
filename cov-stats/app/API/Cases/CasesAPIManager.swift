//
//  CasesAPIManager.swift
//  cov-stats
//
//  Created by Pedro Freddi on 11/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

final class CasesAPIManager {
    struct GetCasesAround: APIRequestable {
        typealias APIResponse = ResponseBody
        var method: HTTPMethod = .get
        var parameters: Parameters?
        var url: String = Constants.Endpoints.casesAround
        var headers: HTTPHeaders?
        var logoutIfUnauthorized: Bool = false
        var apiLoggerLevel: APILoggerLevel = .debug
        
        struct ResponseBody: Codable {
            let casesAround: Int
        }
    }
}
