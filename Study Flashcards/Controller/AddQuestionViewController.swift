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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        questionTextView.layer.borderWidth = 0.5
        questionTextView.layer.borderColor = borderColor.cgColor
        questionTextView.layer.cornerRadius = 5.0
        
        answerTextView.layer.borderWidth = 0.5
        answerTextView.layer.borderColor = borderColor.cgColor
        answerTextView.layer.cornerRadius = 5.0
        
    }

}
