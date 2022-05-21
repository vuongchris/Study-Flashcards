//
//  ViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 9/5/2022.
//

import UIKit
import CoreData

class Results: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class SubjectViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let searchController = UISearchController(searchResultsController: Results())
    var subjects: [Subject]?
    let textCellIdentifier = "textCell"
    
    var editStatus = false
    var submittedSubject: String?
    var edittedSubject: Subject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search title and search bar
        //title = "Search Subject"
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        fetchSubject()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddSubjectView" {
            let destVC = segue.destination as! AddSubjectViewController
            destVC.context = context
        }
    }
    
    func fetchSubject() {
        do {
            self.subjects = try context.fetch(Subject.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
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
        return self.subjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let subjectAtRow = self.subjects![indexPath.row]
        
        cell.textLabel?.text = subjectAtRow.subjectName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let subjectToRemove = self.subjects![indexPath.row]
            
            self.context.delete(subjectToRemove)
            
            do {
                try self.context.save()
            } catch {
                
            }
            
            self.fetchSubject()
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            let subjectToEdit = self.subjects![indexPath.row]
            let destVC = self.storyboard?.instantiateViewController(identifier: "AddSubjectViewController") as! AddSubjectViewController
            destVC.context = self.context
            destVC.editStatus = true
            destVC.text = subjectToEdit.subjectName
            destVC.subjectToEdit = subjectToEdit
            self.navigationController?.pushViewController(destVC, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    
    
    @IBAction func submitAction(_ sender: UIStoryboardSegue) {
        super.setEditing(false, animated: true)
        if editStatus {
            edittedSubject!.subjectName = submittedSubject!
            do {
                try self.context.save()
            } catch {
                
            }
            
            self.fetchSubject()
        } else {
            let newSubject = Subject(context: context)
            newSubject.subjectName = submittedSubject
            
            do {
                try self.context.save()
            } catch {
                
            }
            
            self.fetchSubject()
        }

        
        
        tableView.setEditing(false, animated: true)
    }
}

