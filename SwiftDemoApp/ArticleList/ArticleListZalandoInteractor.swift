//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

protocol ArticleListInteractor {
    func articles(completion: ([String]) -> Void)
}

struct ArticleListZalandoInteractor: ArticleListInteractor {

    func articles(completion: ([String]) -> Void) {
        completion(["Zalando article 1"])
    }
}
