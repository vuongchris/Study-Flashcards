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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subjectTextField.delegate = self
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
    
}
