//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

protocol ArticleListView: class {
    var viewModel: ArticleListViewModel? { get set }
}

protocol ArticleListEventHandler {
    func viewWillAppear()
}

class ArticleListViewController: UITableViewController, ArticleListView {

    var viewModel: ArticleListViewModel?
    var eventHandler: ArticleListEventHandler?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler?.viewWillAppear()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.articles.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListItem", for: indexPath)
        let article = viewModel?.articles.element(at: indexPath.row)
        cell.textLabel?.text = article?.title
        return cell
    }
}
