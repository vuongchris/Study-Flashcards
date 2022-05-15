//
//  ViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 9/5/2022.
//

import UIKit

class Results: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class ViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet var table: UITableView!

    let searchController = UISearchController(searchResultsController: Results())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search title and search bar
        title = "Search Subject"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
    }
    // updates search after every character
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        let rs = searchController.searchResultsController as? Results
        rs?.view.backgroundColor = .systemRed
        print(text)
    }


}

