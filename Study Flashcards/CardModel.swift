//
//  CardModel.swift
//  Study Flashcards
//
//  Created by Briana Margetts on 15/5/2022.
//

import Foundation

struct Card: Identifiable{
    var id = UUID()
    var subject : String
    var question : String
    var answer : String
    
}
