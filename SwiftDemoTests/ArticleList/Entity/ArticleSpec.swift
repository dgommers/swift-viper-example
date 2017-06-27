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
                let expected = "Long sleeved top - stormy weather"
                expect(subject.name).to(equal(expected))
            }

            describe("units") {
                it("parses each unit") {
                    expect(subject.units?.count).to(equal(5))
                }

                it("parses the first unit price") {
                    let expected = "£11.00"
                    expect(subject.units?.first?.price?.formatted).to(equal(expected))
                }
            }

            describe("media") {
                it("parses each image") {
                    expect(subject.media?.images?.count).to(equal(4))
                }

                it("parses the first small hd url") {
                    let expected = URL(string: "https://i2.ztat.net/catalog_hd/BE/82/4G/00/2C/11/BE824G002-C11@8.jpg")
                    expect(subject.media?.images?.first?.smallHdURL).to(equal(expected))
                }
            }
        }
    }
}
