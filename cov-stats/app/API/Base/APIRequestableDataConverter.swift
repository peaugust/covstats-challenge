//
//  APIRequestableDataConverter.swift
//  cov-stats
//
//  Created by Andrio Frizon on 5/7/20.
//  Copyright © 2020 Jungle Devs. All rights reserved.
//

import Foundation
import Alamofire

struct APIRequestableDataConverter {

    // MARK: Variables

    let data: Data!
    let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy!
    let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy!

    // MARK: Life cycle

    init(data: Data, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy) {
        self.data = data
        self.dateDecodingStrategy = dateDecodingStrategy
        self.keyDecodingStrategy = keyDecodingStrategy
    }

    // MARK: Modifier initializers

    @discardableResult
    func with(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) -> APIRequestableDataConverter {
        return APIRequestableDataConverter(data: data, dateDecodingStrategy: dateDecodingStrategy, keyDecodingStrategy: keyDecodingStrategy)
    }

    @discardableResult
    func with(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy) -> APIRequestableDataConverter {
        return APIRequestableDataConverter(data: data, dateDecodingStrategy: dateDecodingStrategy, keyDecodingStrategy: keyDecodingStrategy)
    }

    // MARK: Convert response

    @discardableResult
    func convertResponse<T: Decodable>(response: DataResponse<Data, AFError>?) throws -> T {
        do {
            let responseAsObject = try T.decoded(
                from: data,
                dateDecodingStrategy: dateDecodingStrategy,
                keyDecodingStrategy: keyDecodingStrategy
            )
            return responseAsObject
        } catch let error as DecodingError {
            let emptyResponse = APIResponseEmpty()
            guard let emptyResponseObj = emptyResponse as? T else {
                throw APIError.objectMapping(response, error)
            }
            return emptyResponseObj
        } catch {
            throw APIError.convertResponse(response)
        }
    }
}

extension APIRequestableDataConverter {
    init(fromResponseValidator responseValidator: APIRequestableResponseValidator) {
        data = responseValidator.data
        dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso
        keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
    }
}
