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
        static private func getEndpointURL(_ endpoint: String) -> String {
            return URL.baseURL + endpoint
        }

        static func getPath(forEndpoint endpoint: String) -> String {
            var result = endpoint
                        
            result = result.replacingOccurrences(of: URL.baseURL, with: "")
            return result
        }

        // MARK: Auth

        static var latestData: String { return getEndpointURL("/latest_data/") }
    }
}
