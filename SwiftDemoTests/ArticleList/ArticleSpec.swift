//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleSpec: QuickSpec {
    override func spec() {

        describe("equatable") {
            it("is equal") {
                expect(Article.tesla).to(equal(Article.tesla))
            }
            it("is not equal") {
                expect(Article.tesla).toNot(equal(Article.spaceX))
            }
        }
    }
}

extension Article {
    static var tesla = Article(name: "Tesla", price: "€ 200")
    static var spaceX = Article(name: "SpaceX", price: nil)
}
