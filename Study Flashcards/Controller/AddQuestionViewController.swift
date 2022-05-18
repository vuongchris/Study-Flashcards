//
//  AddQuestionViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 18/5/2022.
//

import Foundation

import UIKit

class AddQuestionViewController: UIViewController, UITextFieldDelegate {
    
    
    var editStatus = false
    //var textPlaceholder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goToSubjectView))
        
        if editStatus == true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(goToSubjectView))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(goToSubjectView))
        }
    }
    
    
    @objc func goToSubjectView() {
        let vc = storyboard?.instantiateViewController(identifier: "SubjectViewController") as! SubjectViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == subjectTextField {
            textField.resignFirstResponder()
        }
        return false
    }
    */
}
