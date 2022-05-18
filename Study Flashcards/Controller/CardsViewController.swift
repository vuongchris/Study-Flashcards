//
//  CardsViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 16/5/2022.
//

import Foundation

import UIKit

class CardsViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var cardsTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: Results())
    let subjectList = ["Card 1", "Card 2", "Card 3", "Card 4", "Card 5"]
    let textCellIdentifier = "textCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search title and search bar
        //title = "Search Subject"
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = editButtonItem

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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardsTableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = subjectList[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "AddQuestionViewController") as! AddQuestionViewController
        vc.editStatus = true
        self.navigationController?.pushViewController(vc, animated: true)
        cardsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        
        cardsTableView.setEditing(editing, animated: true)

    }
    
    @IBAction func submitQuestionAction(_ sender: UIStoryboardSegue) {
        super.setEditing(false, animated: true)
        cardsTableView.setEditing(false, animated: true)
    }
    
}
