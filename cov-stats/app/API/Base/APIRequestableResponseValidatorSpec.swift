//
//  APIRequestableResponseValidatorSpec.swift
//  cov-stats
//
//  Created by Andrio Frizon on 5/7/20.
//  Copyright © 2020 Jungle Devs. All rights reserved.
//

@testable import cov_stats
import Quick
import Nimble
import Alamofire

class APIRequestableResponseValidatorSpec: QuickSpec {

    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("API Requestable Response Validator") {

            context("initialization") {
                it("will set initial status code") {
                    do {
                        try APIRequestableResponseValidator().with(statusCode: nil)
                        fail("Should have thrown no status code error")
                    } catch {
                        expect(error).to(beAnInstanceOf(APIError.self))
                        expect(error as? APIError).to(equal(APIError.noStatusCode(nil)))
                    }

                    do {
                        let responseValidator = try APIRequestableResponseValidator().with(statusCode: 200)
                        expect(responseValidator.statusCode).to(be(200))
                    } catch {
                        fail("Should have succeeded")
                    }
                }

                it("will set initial data") {
                    do {
                        try APIRequestableResponseValidator().with(data: nil)
                        fail("Should have thrown no data error")
                    } catch {
                        expect(error).to(beAnInstanceOf(APIError.self))
                        expect(error as? APIError).to(equal(APIError.noData(nil)))
                    }

                    do {
                        let dataStr = "Some data"
                        let data: Data? = dataStr.data(using: .utf8)
                        let responseValidator = try APIRequestableResponseValidator().with(data: data)
                        let resultStr = String(data: responseValidator.data, encoding: .utf8)
                        expect(dataStr).to(equal(resultStr))
                    } catch {
                        fail("Should have succeeded")
                    }
                }
            }

            context("handling validations") {
                it("will detect status code 401 as unauthorized") {
                    do {
                        try APIRequestableResponseValidator()
                            .with(statusCode: 401)
                            .validateUnauthorizedStatusCode()
                        fail("Should have thrown invalid token error")
                    } catch {
                        expect(error).to(beAnInstanceOf(APIError.self))
                        expect(error as? APIError).to(equal(APIError.invalidToken(nil)))
                    }
                }

                it("will detect status code in range 200~299") {
                    do {
                        let responseValidator = try APIRequestableResponseValidator()
                            .with(statusCode: 200)
                            .validate(statusCodeInRange: 200...299)
                        expect(responseValidator).to(beAnInstanceOf(APIRequestableResponseValidator.self))
                    } catch {
                        fail("Should have succeeded")
                    }

                    do {
                        try APIRequestableResponseValidator()
                            .with(statusCode: 300)
                            .validate(statusCodeInRange: 200...299)
                        fail("Should have thrown invalid status code error")
                    } catch {
                        expect(error).to(beAnInstanceOf(APIError.self))
                        expect(error as? APIError).to(equal(APIError.invalidStatusCode(nil, 300)))
                    }
                }
            }

            context("transformation") {
                it("will transform to data converter ") {
                    do {
                        let dataStr = "Some data"
                        let data: Data? = dataStr.data(using: .utf8)
                        let dataConverter = try APIRequestableResponseValidator().with(data: data).toDataConverter()
                        let resultStr = String(data: dataConverter.data, encoding: .utf8)
                        expect(dataStr).to(equal(resultStr))
                    } catch {
                        fail("Should have succeeded")
                    }
                }
            }
        }
    }
}
