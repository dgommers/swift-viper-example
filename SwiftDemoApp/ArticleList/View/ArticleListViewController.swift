//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

protocol ArticleListView: class {
    var viewModel: ArticleListViewModel? { get set }
}

protocol ArticleListEventHandler {
    func viewWillAppear()
    func viewDidReachBottom()
}

class ArticleListViewController: UITableViewController, ArticleListView {

    var viewModel: ArticleListViewModel? {
        didSet {
            tableView?.reloadData()
        }
    }

    var eventHandler: ArticleListEventHandler?
    private let reachingBottomTreshold = CGFloat(10)
    private let cellIdentifier = "ArticleListItemView"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = ArticleListItemView.estimatedHeight
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler?.viewWillAppear()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.articles.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = cell as? ArticleListItemView
        item?.viewModel = viewModel?.articles.element(at: indexPath.row)
        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let content = scrollView.contentSize.height
        let viewport = scrollView.frame.size.height
        let offset = scrollView.contentOffset.y
        if content - offset - reachingBottomTreshold < viewport {
            eventHandler?.viewDidReachBottom()
        }
    }
}
