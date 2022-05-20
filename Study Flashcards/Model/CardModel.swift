//
//  CardModel.swift
//  Study Flashcards
//
//  Created by Briana Margetts on 15/5/2022.
//

import Foundation

class Card: Identifiable, Codable{
    var id = UUID()
    //var subject : String
    var question : String
    var answer : String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}
