//
//  OptionsViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 16/5/2022.
//

import Foundation

import UIKit

class MainViewController: UIViewController {
    
    var subjectTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = subjectTitle
    }
        
}
