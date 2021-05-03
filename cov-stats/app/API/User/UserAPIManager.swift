//
//  UserAPIManager.swift
//  cov-stats
//
//  Created by Andrio Frizon on 5/4/20.
//  Copyright © 2020 Jungle Devs. All rights reserved.
//

import Foundation
import Alamofire

final class UserAPIManager {
    struct Login: APIRequestable {
        typealias APIResponse = ResponseBody
        var method: HTTPMethod = .post
        var parameters: Parameters?
        var url: String = Constants.Endpoints.login
        var headers: HTTPHeaders?
        var logoutIfUnauthorized: Bool = false
        var apiLoggerLevel: APILoggerLevel = .debug
        var stub: APIRequestableStub? = APIRequestableStub(
            statusCode: 200,
            headers: nil,
            responseBodyObject: ResponseBody(
                key: "randomToken",
                user: User(
                    id: 0,
                    email: "dev@jungledevs.com",
                    firstName: "Dave",
                    lastName: "Loper"
                )
            )
        )

        struct RequestBody: Codable {
            let email: String
            let password: String
        }

        struct ResponseBody: Codable {
            let key: String
            let user: User
        }

        init(requestBody: RequestBody) {
            parameters = requestBody.asParameters
        }
    }
}
