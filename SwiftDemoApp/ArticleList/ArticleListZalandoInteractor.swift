//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

protocol ArticleListInteractor {
    func articles(completion: @escaping ([String]) -> Void)
}

struct ArticleListZalandoInteractor: ArticleListInteractor {

    var session: URLSessionType = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    private let host = "api.zalando.com"

    func articles(completion: @escaping ([String]) -> Void) {
        let url = URL(string: "https://\(host)/articles?fields=name")!
        session.request(with: url) { data, _, _ in
            let root = data?.json as? [String: Any]
            let content = root?["content"] as? [[String: String]]
            let names = content?.flatMap { $0["name"] }
            completion(names ?? [])
        }
    }
}

private extension Data {
    var json: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: [])
    }
}
