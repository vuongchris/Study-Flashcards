//
//  CardsViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 16/5/2022.
//

import Foundation

import UIKit

class CardsViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    let ADD_QUESTION_SEGUE = "goToAddQuestionView"
    
    @IBOutlet weak var cardsTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: Results())
    var subject: Subject?
    var cardList: [Card] = []
    let textCellIdentifier = "textCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search title and search bar
        if subject != nil {
            cardList = subject!.cards
        }
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
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardsTableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = cardList[row].question
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "AddQuestionViewController") as! AddQuestionViewController
        vc.editStatus = true
        vc.cardBeingEdited = cardList[indexPath.row]
        vc.subject = subject
        self.navigationController?.pushViewController(vc, animated: true)
        cardsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        
        cardsTableView.setEditing(editing, animated: true)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //print("DELET")
            guard subject != nil else {return}
            let cardToBeDeleted: Int = indexPath.row
            subject!.removeCard(at: cardToBeDeleted)
            cardList.remove(at: cardToBeDeleted)
            editSubject(subject!)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// Game View Segue
        if segue.identifier == ADD_QUESTION_SEGUE {
            let destinationView = segue.destination as! AddQuestionViewController
            destinationView.subject = subject
            
        }
    }
    
    @IBAction func submitQuestionAction(_ sender: UIStoryboardSegue) {
        super.setEditing(false, animated: true)
        cardsTableView.setEditing(false, animated: true)
    }
    
}
