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

class SubjectViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var actionButton: UIButton!
    let searchController = UISearchController(searchResultsController: Results())
    let subjectList = ["Biology", "Chemistry", "English", "Maths", "Physics"]
    let textCellIdentifier = "textCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search title and search bar
        //title = "Search Subject"
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddSubjectView))
        tableView.allowsSelectionDuringEditing = true

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
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = subjectList[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        tableView.setEditing(editing, animated: true)

    }
    
    @objc func goToAddSubjectView() {
        let vc = storyboard?.instantiateViewController(identifier: "AddSubjectViewController") as! AddSubjectViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

