//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

@testable import SwiftDemoApp

extension Article {
    static let example: Article = Article(json: jsonArticleExample())
}

private func jsonArticleExample() -> Any {
    let name = "ArticleExample"
    let bundle = Bundle(for: ArticleSpec.self)

    guard let url = bundle.url(forResource: name, withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        else {
            fatalError("Failed to read \(name) from test bundle")
    }
    return json
}
