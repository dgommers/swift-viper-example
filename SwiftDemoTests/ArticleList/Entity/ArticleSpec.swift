//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleSpec: QuickSpec {
    override func spec() {

        let bundle = Bundle(for: ArticleSpec.self)
        let url = bundle.url(forResource: "Article", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])

        describe("equatable") {
            it("is equal") {
                expect(Article.tesla).to(equal(Article.tesla))
            }
            it("is not equal") {
                expect(Article.tesla).toNot(equal(Article.spaceX))
            }
        }

        describe("json") {
            var subject: Article!

            beforeEach {
                subject = Article(json: json)
            }

            it("parses the name") {
                expect(subject.name).to(equal("Long sleeved top - stormy weather"))
            }

            it("parses the first unit price") {
                expect(subject.price).to(equal("£11.00"))
            }
        }
    }
}

extension Article {
    static var tesla = Article(name: "Tesla", price: "€ 200")
    static var spaceX = Article(name: "SpaceX", price: nil)
}
