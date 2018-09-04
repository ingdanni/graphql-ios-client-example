//
//  ViewController.swift
//  ApolloClient
//
//  Created by Danny Narvaez on 9/3/18.
//  Copyright © 2018 Danny Narvaez. All rights reserved.
//

import UIKit

typealias Post = FetchPostsQuery.Data.Post?

class ViewController: UITableViewController {
  
  var items: [Post]? {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    title = "Posts"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    apollo.fetch(query: FetchPostsQuery()) { response, error in
      if let response = response,
        let data = response.data,
        let posts = data.post {
        self.items = posts
      }
    }
  }
}

extension ViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let data = items {
      return data.count
    }
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    cell.textLabel?.text = items![indexPath.row]?.title
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.lineBreakMode = .byWordWrapping
    return cell
  }
}


