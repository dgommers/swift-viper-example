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
            context("three articles available") {
                beforeEach {
                    subject.viewModel = ArticleListViewModel(articles: [.mugshot, .selfie, .apple])
                }

                it("shows the first title") {
                    let firstCell = self.tester().waitForCellInTableView(at: IndexPath(row: 0, section: 0))
                    expect(firstCell?.textLabel?.text).to(equal(ArticleListItemViewModel.mugshot.title))
                }

                it("shows the last title") {
                    let firstCell = self.tester().waitForCellInTableView(at: IndexPath(row: 2, section: 0))
                    expect(firstCell?.textLabel?.text).to(equal(ArticleListItemViewModel.apple.title))
                }
            }
        }
    }
}

extension ArticleListItemViewModel {
    static var mugshot = ArticleListItemViewModel(title: "Mugshot Maker PRO+")
    static var selfie = ArticleListItemViewModel(title: "Selfie Stick")
    static var apple = ArticleListItemViewModel(title: "Apple iPhone")
}
