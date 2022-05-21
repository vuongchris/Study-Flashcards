//
//  OptionsViewController.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 16/5/2022.
//

import Foundation

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    
    
    //let FLASH_CARD_VIEW_SEGUE = "flashCardViewSegue"
    let CARDS_VIEW_SEGUE = "cardsViewSegue"
    
    var subject: Subject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var subjectName: String = ""
        if subject != nil {
            subjectName = subject!.subjectName
        }
        navigationItem.title = subjectName
    }
    
    @IBAction func startQuiz(_ sender: Any) {
        let view = ContentView(subject: subject!)
        let host = UIHostingController(rootView: view)
        navigationController?.pushViewController(host, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// Game View Segue
        if segue.identifier == CARDS_VIEW_SEGUE {
            let destinationView = segue.destination as! CardsViewController
            destinationView.subject = subject
        }
//        else if segue.identifier == FLASH_CARD_VIEW_SEGUE {
//            let view = ContentView(subject: subject!)
//            let host = UIHostingController(rootView: view)
//            navigationController?.pushViewController(host, animated: true)
//        }
    }
        
}
