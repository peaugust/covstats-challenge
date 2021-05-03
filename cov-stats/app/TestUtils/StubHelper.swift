//
//  StubHelper.swift
//  cov-statsTests
//
//  Created by Andrio Frizon on 5/5/20.
//  Copyright © 2020 Jungle Devs. All rights reserved.
//

import Foundation
import OHHTTPStubs
import Alamofire
@testable import cov_stats

struct StubHelper {
    static func getHTTPStubsTestBlock(forHttpMethod httpMethod: HTTPMethod) -> HTTPStubsTestBlock {
        switch httpMethod {
        case .get: return isMethodGET()
        case .post: return isMethodPOST()
        case .patch: return isMethodPATCH()
        case .put: return isMethodPUT()
        case .delete: return isMethodDELETE()
        default: return isMethodGET()
        }
    }

    static func setupStub(httpMethod: HTTPMethod, endpoint: String, statusCode: Int32, headers: [AnyHashable: Any]?, responseBodyObject: Encodable) {
        guard let bodyJson = responseBodyObject.asParameters else {
            fatalError("Could not convert body object")
        }

        let httpMethodStubTestBlock = StubHelper.getHTTPStubsTestBlock(forHttpMethod: httpMethod)

        let regexString = StubHelper.getRegexString(forEndpoint: endpoint)

        stub(condition: isHost(Constants.URL.baseURLHost) && httpMethodStubTestBlock && pathMatches(regexString)) { _ in
            return HTTPStubsResponse(jsonObject: bodyJson, statusCode: statusCode, headers: headers)
        }
    }

    private static func getRegexString(forEndpoint endpoint: String) -> String {
        var result: String = Constants.Endpoints.getPath(forEndpoint: endpoint)
        if result.last == "/" {
            result = String(result.dropLast())
        }
        result = result.replacingOccurrences(of: "%@", with: ".*[\\d\\w].*")
        result = "^*" + result + "$"
        return result
    }

    static func removeAllStubs() {
        HTTPStubs.removeAllStubs()
    }
}
