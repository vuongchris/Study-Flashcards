//
//  AddQuestionViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 18/5/2022.
//

import Foundation

import UIKit

class AddQuestionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    
    var editStatus = false
    var cardBeingEdited: Card? = nil
    var subject: Subject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        questionTextView.layer.borderWidth = 0.5
        questionTextView.layer.borderColor = borderColor.cgColor
        questionTextView.layer.cornerRadius = 5.0
        
        answerTextView.layer.borderWidth = 0.5
        answerTextView.layer.borderColor = borderColor.cgColor
        answerTextView.layer.cornerRadius = 5.0
        
        if editStatus {
            questionTextView.text = cardBeingEdited?.question
            answerTextView.text = cardBeingEdited?.answer
        }
    }
    
    func onSave() {
        if questionTextView != nil && answerTextView != nil {
            if !editStatus {
                subject!.cards.append(Card(question: questionTextView.text, answer: answerTextView.text))
            }
            else {
                cardBeingEdited!.answer = answerTextView.text
                cardBeingEdited!.question = questionTextView.text
            }
        }
        editSubject(subject!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// Game View Segue
        if segue.identifier == "cardsViewUnwind" {
            let destinationView = segue.destination as! CardsViewController
            onSave()
            destinationView.subject = subject
            destinationView.cardList = subject!.cards
            
        }
    }

}
