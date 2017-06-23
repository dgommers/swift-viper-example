//  Copyright © 2017 Derk Gommers. All rights reserved.

import KIF
import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleListViewControllerSpec: QuickSpec {
    override func spec() {

        var subject: ArticleListViewController!

        beforeEach {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ArticleListViewController")
            let navigationController = UINavigationController(rootViewController: viewController)

            UIApplication.shared.keyWindow?.rootViewController = navigationController
            subject = viewController as? ArticleListViewController
        }

        it("has title 'Articles'") {
            expect(subject.navigationItem.title).to(equal("Articles"))
        }

        describe("update") {
            context("one article available") {
                var article: ArticleListItemViewModel!

                beforeEach {
                    article = ArticleListItemViewModel(title: "Mugshot maker")
                    subject.update(viewModel: ArticleListViewModel(articles: [article]))
                }

                it("shows the title") {
                    let firstCell = self.tester().waitForCellInTableView(at: IndexPath(row: 0, section: 0))
                    expect(firstCell?.textLabel?.text).to(equal(article.title))
                }
            }
        }
    }
}
