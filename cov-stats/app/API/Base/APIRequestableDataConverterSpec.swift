//
//  APIRequestableDataConverterSpec.swift
//  cov-statsTests
//
//  Created by Andrio Frizon on 5/7/20.
//  Copyright © 2020 Jungle Devs. All rights reserved.
//

@testable import cov_stats
import Quick
import Nimble
import Alamofire

class APIRequestableDataConverterSpec: QuickSpec {

    // swiftlint:disable:next function_body_length cyclomatic_complexity
    override func spec() {
        describe("API Requestable Data Converter") {

             context("initialization") {

                 it("will set date decoding strategy") {
                     let dataConverter = APIRequestableDataConverter(
                         data: Data(),
                         dateDecodingStrategy: .iso8601,
                         keyDecodingStrategy: .convertFromSnakeCase
                     )
                     switch dataConverter.dateDecodingStrategy {
                     case .iso8601: break
                     default: fail("Date decoding strategy should be iso8601")
                     }

                     let deferredToDateDataConverter = dataConverter.with(dateDecodingStrategy: .deferredToDate)
                     switch deferredToDateDataConverter.dateDecodingStrategy {
                     case .deferredToDate: break
                     default: fail("Date decoding strategy should be deferredToDate")
                     }

                     let millisecondsSince1970DataConverter = dataConverter.with(dateDecodingStrategy: .millisecondsSince1970)
                     switch millisecondsSince1970DataConverter.dateDecodingStrategy {
                     case .millisecondsSince1970: break
                     default: fail("Date decoding strategy should be millisecondsSince1970")
                     }
                 }

                 it("will set key decoding strategy") {
                     let dataConverter = APIRequestableDataConverter(
                         data: Data(),
                         dateDecodingStrategy: .iso8601,
                         keyDecodingStrategy: .convertFromSnakeCase
                     )
                     switch dataConverter.keyDecodingStrategy {
                     case .convertFromSnakeCase: break
                     default: fail("Key decoding strategy should be convertFromSnakeCase")
                     }

                     let useDefaultKeysDataConverter = dataConverter.with(keyDecodingStrategy: .useDefaultKeys)
                     switch useDefaultKeysDataConverter.keyDecodingStrategy {
                     case .useDefaultKeys: break
                     default: fail("Key decoding strategy should be useDefaultKeys")
                     }

                     let snakeCaseDataConverter = dataConverter.with(keyDecodingStrategy: .convertFromSnakeCase)
                     switch snakeCaseDataConverter.keyDecodingStrategy {
                     case .convertFromSnakeCase: break
                     default: fail("Key decoding strategy should be convertFromSnakeCase")
                     }
                 }
             }

             context("convert response") {
                 it("converts correctly") {
                     do {
                         let sucessfulLoginResponseBody = UserAPIManager.Login.ResponseBody(
                             key: "randomToken",
                             user: User(
                                 id: 0,
                                 email: "dev@jungledevs.com",
                                 firstName: "Dave",
                                 lastName: "Loper"
                             )
                         )

                         let sucessfulLoginResponseData = try JSONEncoder().encode(sucessfulLoginResponseBody)

                         let response: DataResponse<Data, AFError>? = DataResponse<Data, AFError>(
                             request: nil,
                             response: nil,
                             data: sucessfulLoginResponseData,
                             metrics: nil,
                             serializationDuration: 0,
                             result: .success(sucessfulLoginResponseData)
                         )

                         let convertedResponseObject: UserAPIManager.Login.ResponseBody = try APIRequestableResponseValidator(response: response)
                             .with(data: response?.data)
                             .toDataConverter()
                             .convertResponse(response: response)

                         let convertedKey = convertedResponseObject.key
                         let responseKey = sucessfulLoginResponseBody.key
                         expect(convertedKey).to(equal(responseKey))

                         let convertedUser = convertedResponseObject.user
                         let responseUser = sucessfulLoginResponseBody.user
                         expect(convertedUser.id).to(equal(responseUser.id))
                         expect(convertedUser.email).to(equal(responseUser.email))
                         expect(convertedUser.firstName).to(equal(responseUser.firstName))
                         expect(convertedUser.lastName).to(equal(responseUser.lastName))
                     } catch {
                         fail("Should have succeeded")
                     }
                 }

                 it("fails when missing some key") {
                     do {
                         let missingKeyResponseBody: [String: Any] = [
                             "key": "randomToken",
                             "user": [
                                 "id": 0,
                                 "lastName": "Loper"
                             ]
                         ]

                         let missingKeyResponseData = try JSONSerialization.data(withJSONObject: missingKeyResponseBody, options: [])

                         let response: DataResponse<Data, AFError>? = DataResponse<Data, AFError>(
                             request: nil,
                             response: nil,
                             data: missingKeyResponseData,
                             metrics: nil,
                             serializationDuration: 0,
                             result: .success(missingKeyResponseData)
                         )

                         _ = try APIRequestableResponseValidator(response: response)
                             .with(data: response?.data)
                             .toDataConverter()
                             .convertResponse(response: response) as UserAPIManager.Login.ResponseBody

                         fail("Shoud have failed")
                     } catch {
                         expect(error).to(beAnInstanceOf(APIError.self))
                         expect(error as? APIError).to(equal(APIError.objectMapping(nil, nil)))
                     }
                 }
             }
         }
    }
}
