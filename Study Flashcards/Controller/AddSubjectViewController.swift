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
    }
    
    @IBAction func onSave(_ sender: Any) {
        if subjectTextField.text != nil {
            if !editStatus {
                writeSubject(Subject(
                    subjectName: subjectTextField.text!,
                    cards: []
                ))
            }
            else {
                // Edit subject
                editSubjectName(subjectBeingEdited, subjectTextField.text!)
            }
        }
        goToSubjectView()
    }
    
    @objc func goToSubjectView() {
        let vc = storyboard?.instantiateViewController(identifier: "SubjectViewController") as! SubjectViewController
        vc.subjectList = readSubject()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == subjectTextField {
            textField.resignFirstResponder()
        }
        return false
    }
    
}
