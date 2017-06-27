//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

struct Article {
    var name: String?
    var units: [ArticleUnit]?

    init() { }

    init(json: Any?) {
        let jsonRoot = json as? [String: Any]
        let jsonUnits = jsonRoot?["units"] as? [Any]

        units = jsonUnits?.map { ArticleUnit(json: $0) }
        name = jsonRoot?["name"] as? String
    }
}

struct ArticleUnit {
    var price: ArticlePrice?

    init() { }

    init(json: Any?) {
        let jsonRoot = json as? [String: Any]
        price = ArticlePrice(json: jsonRoot?["price"])
    }
}

struct ArticlePrice {
    var formatted: String?

    init() { }

    init(json: Any? = nil) {
        let jsonRoot = json as? [String: Any]
        formatted = jsonRoot?["formatted"] as? String
    }
}
