//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

@testable import SwiftDemoApp

class URLSessionStub: URLSessionType {
    var invokedRequest: (url: URL, completionHandler: (Data?, URLResponse?, Error?) -> Void)?

    func request(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        invokedRequest = (url: url, completionHandler: completionHandler)
    }
}
