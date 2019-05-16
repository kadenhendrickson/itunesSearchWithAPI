//
//  ItunesListTableViewController.swift
//  itunesSearchWithAPI
//
//  Created by Kaden Hendrickson on 5/16/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class ItunesListTableViewController: UITableViewController {
    
    var results: [itunesResults] = []

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath) as! ItunesItemTableViewCell

        let result = results[indexPath.row]
        cell.itunesResult = result
        cell.artworkImageView.image = nil
        
        itunesResultsController.fetchImageWith(itunesItem: result) { (image) in
            DispatchQueue.main.async {
                cell.artworkImageView.image = image
            }
        }
        
        return cell
    
    }
}

extension ItunesListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        itunesResultsController.searchItunesWith(searchTerm: searchTerm) { (results) in
            self.results = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
