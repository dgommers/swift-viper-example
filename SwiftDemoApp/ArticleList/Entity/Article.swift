//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

struct Article {
    var name: String?
    var units: [ArticleUnit]?
    var media: ArticleMedia?

    init() { }

    init(json: Any?) {
        let jsonRoot = json as? [String: Any]
        let jsonUnits = jsonRoot?["units"] as? [Any]

        name = jsonRoot?["name"] as? String
        units = jsonUnits?.map { ArticleUnit(json: $0) }
        media = ArticleMedia(json: jsonRoot?["media"])
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

struct ArticleMedia {
    var images: [ArticleImage]?

    init() { }

    init(json: Any? = nil) {
        let jsonRoot = json as? [String: Any]
        let jsonImages = jsonRoot?["images"] as? [Any]
        images = jsonImages?.map { ArticleImage(json: $0) }
    }
}

struct ArticleImage {
    var smallHdUrl: String?

    init() { }

    init(json: Any? = nil) {
        let jsonRoot = json as? [String: Any]
        smallHdUrl = jsonRoot?["smallHdUrl"] as? String
    }
}
