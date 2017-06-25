//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleListZalandoInteractorSpec: QuickSpec {
    override func spec() {

        var session: URLSessionStub!
        var subject: ArticleListZalandoInteractor!

        beforeEach {
            session = URLSessionStub()
            subject = ArticleListZalandoInteractor(session: session)
        }

        describe("default session") {
            var defaultSession: URLSession!

            beforeEach {
                defaultSession = ArticleListZalandoInteractor().session as? URLSession
            }

            it("uses the main delegete queue") {
                expect(defaultSession.delegateQueue).to(equal(OperationQueue.main))
            }

            it("uses default configuration") {
                expect(defaultSession.configuration).to(equal(URLSessionConfiguration.default))
            }

            it("has no delegate") {
                expect(defaultSession.delegate).to(beNil())
            }
        }

        describe("articles") {
            var reported: [String]?

            beforeEach {
                reported = nil
                subject.articles {
                    reported = $0
                }
            }

            describe("request") {
                it("points to api.zalando.com") {
                    expect(session.invokedRequest?.url.host).to(equal("api.zalando.com"))
                }

                it("has a secure connection") {
                    expect(session.invokedRequest?.url.scheme).to(equal("https"))
                }

                it("looks for articles") {
                    expect(session.invokedRequest?.url.path).to(equal("/articles"))
                }

                it("only uses the name field") {
                    expect(session.invokedRequest?.url.query).to(equal("fields=name"))
                }
            }

            describe("response with articles") {
                let articleNameTesla = "Tesla"
                let articleNameSpaceX = "SpaceX"

                beforeEach {
                    let response = ["content": [
                        ["name": articleNameTesla],
                        ["name": articleNameSpaceX]
                    ]]

                    let data = try? JSONSerialization.data(withJSONObject: response, options: [])
                    session.invokedRequest?.completionHandler(data, nil, nil)
                }

                it("reports the article names") {
                    expect(reported).to(equal([articleNameTesla, articleNameSpaceX]))
                }
            }
        }
    }
}
