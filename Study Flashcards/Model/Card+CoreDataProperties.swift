//
//  Card+CoreDataProperties.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 21/5/2022.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var question: String?
    @NSManaged public var answer: String?
    @NSManaged public var subject: Subject?

}

extension Card : Identifiable {

}
