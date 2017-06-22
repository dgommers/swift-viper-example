//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

class ExampleSpec: QuickSpec {
    override func spec() {
        it("runs at least one test to test CI") {
            let runs = true
            expect(runs).to(beTrue())
        }
    }
}
