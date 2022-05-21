//
//  Subject+CoreDataProperties.swift
//  Study Flashcards
//
//  Created by Christopher Vuong on 21/5/2022.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var subjectName: String?
    @NSManaged public var cards: NSSet?

}

// MARK: Generated accessors for cards
extension Subject {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

extension Subject : Identifiable {

}
