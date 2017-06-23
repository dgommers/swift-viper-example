//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

class ArticleListViewController: UITableViewController {

    var viewModel: ArticleListViewModel?

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListItem", for: indexPath)
        let article = viewModel?.articles.first
        cell.textLabel?.text = article?.title
        return cell
    }
}
