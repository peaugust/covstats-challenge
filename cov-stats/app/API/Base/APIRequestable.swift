//
//  APIRequestable.swift
//  cov-stats
//
//  Created by Ígor Yamamoto on 07/06/19.
//  Copyright © 2019 Jungle Devs. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequestable {
    associatedtype APIResponse: Decodable

    var url: String { get set }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get set }

    var logoutIfUnauthorized: Bool { get }
    var apiLoggerLevel: APILoggerLevel { get }
    var headers: HTTPHeaders? { get }

    var stub: APIRequestableStub? { get }

    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }

    func request(withStub stub: APIRequestableStub?, completion: @escaping (APIResult<APIResponse>) -> Void) -> APIRequest?
}

extension APIRequestable {
    public var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        return JSONDecoder.DateDecodingStrategy.iso
    }

    public var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        return JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
    }

    public var headers: HTTPHeaders? {
        guard let token = SessionHelper.shared.authToken else { return HTTPHeaders() }
        return ["Authorization": "Token \(token)"]
    }

    public var apiLoggerLevel: APILoggerLevel {
        return .off
    }

    public var logoutIfUnauthorized: Bool {
        return true
    }

    public var stub: APIRequestableStub? {
        return nil
    }

    static public var isInternetAvailable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

extension APIRequestable {
    private func logIfNeeded(_ text: String) {
        if apiLoggerLevel == .debug {
            log.d(text)
        }
    }

    @discardableResult
    func request(withStub stub: APIRequestableStub? = nil, completion: @escaping (APIResult<APIResponse>) -> Void) -> APIRequest? {
        guard Self.isInternetAvailable else {
            completion(.failure(.internetConnection))
            return nil
        }

        setupStub(stub ?? self.stub)

        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        let request = makeRequest(encoding: encoding)
        APILogger.shared.addRequestToLogger(request: request, loggerLevel: self.apiLoggerLevel)

        return request.responseData { response in
                switch response.result {
                case .success:
                    do {
                        let convertedResponseObject: APIResponse = try APIRequestableResponseValidator(response: response)
                            .with(statusCode: response.response?.statusCode)
                            .validateUnauthorizedStatusCode()
                            .validate(statusCodeInRange: 200...299)
                            .with(data: response.data)
                            .toDataConverter()
                            .with(keyDecodingStrategy: self.keyDecodingStrategy)
                            .with(dateDecodingStrategy: self.dateDecodingStrategy)
                            .convertResponse(response: response)

                        completion(.success(convertedResponseObject))
                    } catch let error as APIError {
                        self.logIfNeeded("[REQUEST ERROR] APIError: \(error.debugDescription)")
                        if error == APIError.invalidToken(nil) && self.logoutIfUnauthorized { // Logout if needed
                            SessionHelper.shared.logout()
                        }
                        completion(APIResult.failure(error))
                    } catch {
                        self.logIfNeeded("[REQUEST ERROR] Unkown: \(error.localizedDescription)")
                        completion(APIResult.failure(.unkown(response)))
                    }
                case let .failure(error):
                    switch error {
                    case .explicitlyCancelled:
                        self.logIfNeeded("[REQUEST ERROR] Cancelled")
                    default:
                        self.logIfNeeded("[REQUEST ERROR] Unkown: \(error.localizedDescription)")
                        completion(APIResult.failure(.unkown(response)))
                    }
                }
        }
    }

    private func makeRequest(encoding: ParameterEncoding) -> DataRequest {
        return AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }
}

// MARK: - Stubs

struct APIRequestableStub {
    let statusCode: Int32
    let headers: [AnyHashable: Any]?
    let responseBodyObject: Encodable
}

extension APIRequestable {
    private func setupStub(_ stub: APIRequestableStub?) {
        guard let stub = stub else { return }
        StubHelper.setupStub(
            httpMethod: self.method,
            endpoint: self.url,
            statusCode: stub.statusCode,
            headers: stub.headers,
            responseBodyObject: stub.responseBodyObject
        )
    }
}
