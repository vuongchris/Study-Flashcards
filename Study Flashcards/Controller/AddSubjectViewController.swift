//
//  AddSubjectViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 17/5/2022.
//

import Foundation

import UIKit
import CoreData

class AddSubjectViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    var editStatus = false
    var context: NSManagedObjectContext?
    var text: String?
    var subjectToEdit: Subject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subjectTextField.delegate = self
        
        if editStatus {
            self.subjectTextField.text = text
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        subjectTextField.resignFirstResponder()
        let destVC = segue.destination as! SubjectViewController
        destVC.editStatus = self.editStatus
        destVC.submittedSubject = text
        destVC.edittedSubject = subjectToEdit
        
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        text = subjectTextField.text
    }
    
}
