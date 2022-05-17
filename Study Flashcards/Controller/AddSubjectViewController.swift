//
//  AddSubjectViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 17/5/2022.
//

import Foundation

import UIKit

class AddSubjectViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goToSubjectView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(goToSubjectView))
    }
    
    
    @objc func goToSubjectView() {
        let vc = storyboard?.instantiateViewController(identifier: "SubjectViewController") as! SubjectViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
