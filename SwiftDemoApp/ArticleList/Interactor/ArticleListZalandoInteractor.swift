//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

protocol ArticleListInteractor {
    func articles(page: UInt, completion: @escaping ([Article]) -> Void)
}

struct ArticleListZalandoInteractor: ArticleListInteractor {

    var session: URLSessionType = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)

    private let host = "api.zalando.com"
    private let fields = ["name", "color", "media.images.smallHdUrl",
                          "units.price.formatted", "units.stock",
                          "units.available", "units.size"]

    func articles(page: UInt, completion: @escaping ([Article]) -> Void) {
        let query = "fields=\(fields.joined(separator: ","))&page=\(page)"
        let url = URL(string: "https://\(host)/articles?\(query)")!
        session.request(with: url) { data, _, _ in
            let root = data?.json as? [String: Any]
            let content = root?["content"] as? [Any]
            let articles = content?.map { Article(json: $0) }
            completion(articles ?? [])
        }
    }
}

private extension Data {
    var json: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: [])
    }
}
