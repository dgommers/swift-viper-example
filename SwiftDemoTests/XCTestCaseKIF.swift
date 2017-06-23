//  Copyright © 2017 Derk Gommers. All rights reserved.

import KIF

extension XCTestCase {
    func tester(file: String = #file, _ line: Int = #line) -> KIFUIViewTestActor {
        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }
}
