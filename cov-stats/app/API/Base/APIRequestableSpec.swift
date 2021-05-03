//
//  APIRequestableSpec.swift
//  cov-statsTests
//
//  Created by Andrio Frizon on 5/5/20.
//  Copyright © 2020 Jungle Devs. All rights reserved.
//

@testable import cov_stats
import Quick
import Nimble
import Alamofire

class APIRequestableSpec: QuickSpec {

    let loginRequestBody = UserAPIManager.Login.RequestBody(
        email: "dev@jungledevs.com",
        password: "password"
    )

    let sucessfulLoginResponseBody = UserAPIManager.Login.ResponseBody(
        key: "randomToken",
        user: User(
            id: 0,
            email: "dev@jungledevs.com",
            firstName: "Dave",
            lastName: "Loper"
        )
    )

    let unauthorizedLoginResponseBody: [String: Any] = [
        "detail": "Invalid token."
    ]

    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("API Requestable") {

            context("handling successful responses") {
                afterEach {
                    StubHelper.removeAllStubs()
                }

                it("will have the object converted") {
                    waitUntil { done in
                        let stub = APIRequestableStub(
                            statusCode: 200,
                            headers: nil,
                            responseBodyObject: self.sucessfulLoginResponseBody
                        )
                        UserAPIManager.Login(requestBody: self.loginRequestBody).request(withStub: stub) { result in
                            switch result {
                            case .failure(let error):
                                fail("Sign in should have succeeded: \(error.localizedDescription)")
                            case .success(let userSignInResponse):
                                let body = self.sucessfulLoginResponseBody
                                let token: String = userSignInResponse.key
                                expect(token).to(equal(body.key))
                                let user = userSignInResponse.user
                                expect(user.id).to(equal(body.user.id))
                                expect(user.email).to(equal(body.user.email))
                                expect(user.firstName).to(equal(body.user.firstName))
                                expect(user.lastName).to(equal(body.user.lastName))
                            }
                            done()
                        }
                    }
                }
            }

            context("handling failure responses") {
                afterEach {
                    StubHelper.removeAllStubs()
                }

                it("will handle invalid token") {
                    waitUntil { done in
                        let stub = APIRequestableStub(
                            statusCode: 401,
                            headers: nil,
                            responseBodyObject: self.sucessfulLoginResponseBody
                        )
                        UserAPIManager.Login(requestBody: self.loginRequestBody).request(withStub: stub) { result in
                            switch result {
                            case .failure(let error):
                                expect(error).to(equal(APIError.invalidToken(nil)))
                            case .success:
                                fail("Sign in should have failed")
                            }
                            done()
                        }
                    }
                }

                it("will handle status codes out of 200~299") {
                    let testWithStatusCode: ((Int) -> Void) = { statusCode in
                        StubHelper.removeAllStubs()

                        waitUntil { done in
                            let stub = APIRequestableStub(
                                statusCode: Int32(statusCode),
                                headers: nil,
                                responseBodyObject: self.sucessfulLoginResponseBody
                            )
                            UserAPIManager.Login(requestBody: self.loginRequestBody).request(withStub: stub) { result in
                                switch result {
                                case .failure(let error):
                                    expect(error).to(equal(APIError.invalidStatusCode(nil, statusCode)))
                                case .success:
                                    fail("Sign in should have failed")
                                }
                                done()
                            }
                        }
                    }

                    testWithStatusCode(500)
                    testWithStatusCode(470)
                    let randomStatusCode = Int.random(in: 300...599)
                    testWithStatusCode(randomStatusCode)
                }

                it("will handle decode failure") {
                    waitUntil { done in
                        let stub = APIRequestableStub(
                            statusCode: 200,
                            headers: nil,
                            responseBodyObject: [
                                "key": "randomToken"
                            ]
                        )
                        UserAPIManager.Login(requestBody: self.loginRequestBody).request(withStub: stub) { result in
                            switch result {
                            case .failure(let error):
                                expect(error).to(equal(APIError.objectMapping(nil, nil)))
                            case .success:
                                fail("Sign in should have failed")
                            }
                            done()
                        }
                    }
                }
            }
        }
    }
}
