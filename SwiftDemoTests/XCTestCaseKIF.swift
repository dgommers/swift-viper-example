//  Copyright © 2017 Derk Gommers. All rights reserved.

import KIF
import Quick

extension XCTestCase {
    func tester(file: String = #file, _ line: Int = #line) -> KIFUIViewTestActor {
        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }

    func capture(name: String, file: String = #file, _ line: Int = #line) {
        let actor = KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
        it("captures screen \(name)") {
            actor?.captureScreenshot(withDescription: name)
        }
    }
}
