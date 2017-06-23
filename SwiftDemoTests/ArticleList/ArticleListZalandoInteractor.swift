//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleListZalandoInteractorSpec: QuickSpec {
    override func spec() {
        var subject: ArticleListZalandoInteractor!

        beforeEach {
            subject = ArticleListZalandoInteractor()
        }

        describe("articles") {
            it("has one article") {
                waitUntil { done in
                    subject.articles { articles in
                        expect(articles.first).toNot(beNil())
                        done()
                    }
                }
            }
        }
    }
}
