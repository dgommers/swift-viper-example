//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

struct ArticleListRouter {

    private let storyboardIdentifier = "Main"
    private let viewControllerIdentifier = "ArticleListViewController"

    func viewController () -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        let articleListViewController = viewController as? ArticleListViewController
        let presenter = ArticleListPresenter(view: articleListViewController)

        articleListViewController?.eventHandler = presenter

        return viewController
    }
}
