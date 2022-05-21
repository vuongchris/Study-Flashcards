//
//  AddQuestionViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 18/5/2022.
//

import Foundation

import UIKit
import CoreData

class AddQuestionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    
    var editStatus = false
    var context: NSManagedObjectContext?
    var subjectSelected: Subject?
    var cardToEdit: Card?
    
    var questionText: String?
    var answerText: String?
    
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
            questionTextView.text = questionText
            answerTextView.text = answerText
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        questionTextView.resignFirstResponder()
        answerTextView.resignFirstResponder()
        let destVC = segue.destination as! CardsViewController
        destVC.context = context
        destVC.subjectSelected = subjectSelected
        destVC.editStatus = editStatus
        destVC.submittedQuestion = questionText
        destVC.submittedAnswer = answerText
        destVC.edittedCard = cardToEdit
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            questionTextView.resignFirstResponder()
            answerTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

