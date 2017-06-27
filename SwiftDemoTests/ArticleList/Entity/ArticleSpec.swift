//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleSpec: QuickSpec {
    override func spec() {

        describe("json example") {
            var subject: Article!

            beforeEach {
                subject = Article.example
            }

            it("parses the name") {
                expect(subject.name).to(equal("Long sleeved top - stormy weather"))
            }

            it("parses each unit") {
                expect(subject.units?.count).to(equal(5))
            }

            it("parses the first unit price") {
                expect(subject.units?.first?.price?.formatted).to(equal("£11.00"))
            }
        }
    }
}
