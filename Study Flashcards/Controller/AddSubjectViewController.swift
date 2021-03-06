//
//  AddSubjectViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 17/5/2022.
//

import Foundation

import UIKit

class AddSubjectViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    var editStatus = false
    var subjectBeingEdited: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subjectTextField.delegate = self
        
        subjectTextField.text = subjectBeingEdited
        
    }
    
    @IBAction func onSave(_ sender: Any) {
        if subjectTextField.text != nil {
            if !editStatus {
                writeSubject(Subject(
                    subjectTextField.text!,
                    []
                ))
            }
            else {
                // Edit subject
                editSubjectName(subjectBeingEdited, subjectTextField.text!)
            }
        }
    }
    
    @objc func goToSubjectView() {
        let vc = storyboard?.instantiateViewController(identifier: "SubjectViewController") as! SubjectViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == subjectTextField {
            textField.resignFirstResponder()
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// Game View Segue
        if segue.identifier == "subjectsViewUnwind" {
            let destinationView = segue.destination as! SubjectViewController
            destinationView.subjectList = readSubject()
        }
    }
    
}
