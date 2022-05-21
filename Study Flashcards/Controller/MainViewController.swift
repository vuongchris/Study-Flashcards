//
//  OptionsViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 16/5/2022.
//

import Foundation

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    var context: NSManagedObjectContext?
    var subjectSelected: Subject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = subjectSelected?.subjectName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCardView" {
            let destVC = segue.destination as! CardsViewController
            destVC.context = context
            destVC.subjectSelected = subjectSelected
        }
    }
        
}
