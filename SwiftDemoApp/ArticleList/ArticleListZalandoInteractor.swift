//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

protocol ArticleListInteractor {
    func articles(page: UInt, completion: @escaping ([Article]) -> Void)
}

struct ArticleListZalandoInteractor: ArticleListInteractor {

    var session: URLSessionType = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    private let host = "api.zalando.com"

    func articles(page: UInt, completion: @escaping ([Article]) -> Void) {
        let url = URL(string: "https://\(host)/articles?fields=name,units.price.formatted&page=\(page)")!
        session.request(with: url) { data, _, _ in
            let root = data?.json as? [String: Any]
            let content = root?["content"] as? [[String: Any]]
            let articles = content?.map { Article(dictionary: $0) }
            completion(articles ?? [])
        }
    }
}

private extension Data {
    var json: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: [])
    }
}

private extension Article {

    private typealias Unit = [String: Price]
    private typealias Price = [String: String]

    init(dictionary: [String: Any]) {
        let units = dictionary["units"] as? [Unit]

        name = dictionary["name"] as? String
        price = units?.first?["price"]?["formatted"]
    }
}
