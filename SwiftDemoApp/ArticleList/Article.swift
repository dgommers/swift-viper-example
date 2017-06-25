//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

struct Article {
    var name: String?
    var price: String?
}

extension Article: Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.name == rhs.name
            && lhs.price == rhs.price
    }
}
