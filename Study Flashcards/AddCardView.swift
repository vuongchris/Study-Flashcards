//
//  AddCardView.swift
//  Study Flashcards
//
//  Created by Ronan Konstantin on 16/05/22.
//

import UIKit

class AddCardView: UIViewController {
    
    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet weak var questionField: UITextView!
    @IBOutlet weak var answerField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onAddButtonClick(_ sender: Any) {
        guard subjectField.text != nil && questionField.text != nil && answerField.text != nil else {
            // One field empty error
            print("ERROR: At least one field empty!")
            return
        }
        addCard(subjectField.text!, questionField.text!, answerField.text!)
    }
    
    func addCard(_ subject: String, _ question: String, _ answer: String) {
        let card: Card = Card(subject: subject, question: question, answer: answer)
        
        // Save card data
        
        // Test: Print card on console
        print("Subject: \(card.subject), Question: \(card.question), Answer: \(card.answer)")
    }
}
