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
    
    let searchController = UISearchController(searchResultsController: Results())
    var subjectList: [Subject] = []
    let textCellIdentifier = "textCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search title and search bar
        //title = "Search Subject"
//        writeSubject(Subject(subjectName: "Physics", cards: [Card(question:"a", answer:"a")]))
        subjectList = readSubject()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = editButtonItem
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
        cell.textLabel?.text = subjectList[row].subjectName
        
        return cell
    }
    
    /// On selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if tableView.isEditing  == true {
            let vc = storyboard?.instantiateViewController(identifier: "AddSubjectViewController") as! AddSubjectViewController
            
            if tableView.isEditing == true {
                vc.editStatus = true
            } else {
                vc.editStatus = false
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
            vc.subjectTitle = subjectList[row].subjectName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("DELET")
            let subjToBeDeleted: Int = indexPath.row
            removeSubject(subjectList[subjToBeDeleted].subjectName)
            subjectList.remove(at: subjToBeDeleted)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        tableView.setEditing(editing, animated: true)

    }
    
    @IBAction func submitAction(_ sender: UIStoryboardSegue) {
        super.setEditing(false, animated: true)
        tableView.setEditing(false, animated: true)
    }
}

