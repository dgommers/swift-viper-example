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
            let page = UInt(2)
            var reported: [Article]?

            beforeEach {
                reported = nil
                subject.articles(page: page) {
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

                it("limts the number of fields") {
                    expect(session.invokedRequest?.url.query).to(contain("fields=name,units.price.formatted"))
                }

                it("requires the correct page") {
                    expect(session.invokedRequest?.url.query).to(contain("&page=\(page)"))
                }
            }

            describe("response with articles") {
                beforeEach {
                    let response = ["content": [
                        ["name": Article.tesla.name as Any, "units": [["price": ["formatted": Article.tesla.price]]]],
                        ["name": Article.spaceX.name as Any]
                    ]]

                    let data = try? JSONSerialization.data(withJSONObject: response, options: [])
                    session.invokedRequest?.completionHandler(data, nil, nil)
                }

                it("reports the article names") {
                    expect(reported).to(equal([Article.tesla, Article.spaceX]))
                }
            }
        }
    }
}
