//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

protocol URLSessionType {
    func request(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLSessionType {
    func request(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: url, completionHandler: completionHandler).resume()
    }
}
