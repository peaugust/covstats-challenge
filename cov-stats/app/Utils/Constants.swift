//
//  Constants.swift
//  cov-stats
//
//  Created by Andrio Frizon on 5/5/20.
//  Copyright © 2020 Jungle Devs. All rights reserved.
//

import Foundation

enum Constants {
    enum URL {
        static let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as! String // swiftlint:disable:this force_cast
        static var baseURLHost: String {
            return URL.baseURL
                .replacingOccurrences(of: "https://", with: "")
                .replacingOccurrences(of: "http://", with: "")
        }
    }

    enum Endpoints {
        private enum Version: String, CaseIterable {
            case v1, v2
        }

        static private func getEndpointURL(_ version: Version, _ endpoint: String) -> String {
            return URL.baseURL + "/api/" + version.rawValue + endpoint
        }

        static func getPath(forEndpoint endpoint: String) -> String {
            var result = endpoint
            for version in Version.allCases {
                result = result.replacingOccurrences(of: URL.baseURL + "/api/" + version.rawValue, with: "")
            }
            return result
        }

        // MARK: Auth

        static var login: String { return getEndpointURL(.v1, "/login/") }
    }
}
