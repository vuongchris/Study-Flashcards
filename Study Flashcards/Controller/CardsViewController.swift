//
//  CardsViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 16/5/2022.
//

import Foundation

import UIKit
import CoreData

class CardsViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var cardsTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: Results())
    let textCellIdentifier = "textCell"
    
    var context: NSManagedObjectContext?
    var subjectSelected: Subject?
    var cardList: [Card]?
    
    var submittedQuestion: String?
    var submittedAnswer: String?
    var editStatus = false
    var edittedCard: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search title and search bar
        //title = "Search Subject"
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.title = subjectSelected?.subjectName
        fetchCards()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddQuestionView" {
            let destVC = segue.destination as! AddQuestionViewController
            destVC.context = context
            destVC.subjectSelected = subjectSelected
        }
    }
    
    func fetchCards() {
        do {
            let request = Card.fetchRequest()
            //let subjectString = subjectSelected!.subjectName!
            //let pred = NSPredicate(format: "subject = %@", subjectString)
            //request.predicate = pred
            self.cardList = try context!.fetch(request)
            DispatchQueue.main.async {
                self.cardsTableView.reloadData()
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
        
        return self.cardList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardsTableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        let cardAtRow = self.cardList![indexPath.row]
        cell.textLabel?.text = cardAtRow.question
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cardsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let subjectToRemove = self.cardList![indexPath.row]
            
            self.context!.delete(subjectToRemove)
            
            do {
                try self.context!.save()
            } catch {
                
            }
            
            self.fetchCards()
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            let cardToEdit = self.cardList![indexPath.row]
            let destVC = self.storyboard?.instantiateViewController(identifier: "AddQuestionViewController") as! AddQuestionViewController
            destVC.context = self.context
            destVC.subjectSelected = self.subjectSelected
            destVC.editStatus = true
            destVC.questionText = cardToEdit.question
            destVC.answerText = cardToEdit.answer
            destVC.cardToEdit = cardToEdit
            self.navigationController?.pushViewController(destVC, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    @IBAction func submitQuestionAction(_ sender: UIStoryboardSegue) {
        super.setEditing(false, animated: true)
        if editStatus {
            edittedCard!.question = submittedQuestion!
            edittedCard!.answer = submittedAnswer!
            
            do {
                try self.context!.save()
            } catch {
                
            }
            
            self.fetchCards()
        } else {
            let newCard = Card(context: context!)
            newCard.question = submittedQuestion
            newCard.answer = submittedAnswer
            
            subjectSelected?.addToCards(newCard)
            
            do {
                try self.context!.save()
            } catch {
                
            }
            
            self.fetchCards()
        }
        cardsTableView.setEditing(false, animated: true)
    }
    
}
