//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

struct Article {
    var name: String?
    var price: String?

    init(name: String?, price: String?) {
        self.name = name
        self.price = price
    }
}

extension Article {
    init(json: Any) {
        let root = json as? [String: Any]
        let units = root?["units"] as? [[String: Any]]
        let unitPrice = units?.first?["price"] as? [String: Any]

        name = root?["name"] as? String
        price = unitPrice?["formatted"] as? String
    }
}

extension Article: Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.name == rhs.name
            && lhs.price == rhs.price
    }
}
