//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

struct Article {
    var name: String?
}

extension Article: Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.name == rhs.name
    }
}
