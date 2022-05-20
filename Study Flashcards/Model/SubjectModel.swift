//
//  SubjectModel.swift
//  Study Flashcards
//
//  Created by Ronan Konstantin on 20/05/22.
//

import Foundation

class Subject: Identifiable, Codable {
    var id = UUID()
    var subjectName: String
    var cards: [Card]
    
    init(_ subjectName: String, _ cards: [Card]) {
        self.subjectName = subjectName
        self.cards = cards
    }
    
    func addCard(question: String, answer: String) {
        cards.append(Card(question: question, answer: answer))
    }
    
    func removeCard(at: Int) {
        cards.remove(at: at)
    }
}

let SUBJECTS_KEY = "subjectKey"

/// Writes into subject user defaults
func writeSubject(_ subject: Subject) {
    let defaults = UserDefaults.standard
    var subjArray = readSubject()
    subjArray.append(subject)
    defaults.set(try? PropertyListEncoder().encode(subjArray), forKey: SUBJECTS_KEY)
}

/// Reads from subject user defaults
func readSubject() -> [Subject] {
    let defaults = UserDefaults.standard
    
    if let savedArrayData = defaults.value(forKey: SUBJECTS_KEY) as? Data {
        if let array = try? PropertyListDecoder().decode(Array<Subject>.self, from: savedArrayData) {
            return array
        }
        return [] as! [Subject]
    }
    return [] as! [Subject]
}

/// Remove subject from user defaults
func removeSubject(_ subjectName: String) {
    let defaults = UserDefaults.standard
    var subjArray = readSubject()
    for (index, subject) in subjArray.enumerated() {
        if subject.subjectName == subjectName {
            subjArray.remove(at: index)
            break
        }
    }
    defaults.set(try? PropertyListEncoder().encode(subjArray), forKey: SUBJECTS_KEY)
}

/// Edit subject name
func editSubjectName(_ oldSubjectName: String, _ newSubjectName: String) {
    let defaults = UserDefaults.standard
    let subjArray = readSubject()
    for (index,subject) in subjArray.enumerated() {
        if subject.subjectName == oldSubjectName {
            subjArray[index].subjectName = newSubjectName
            break
        }
    }
    defaults.set(try? PropertyListEncoder().encode(subjArray), forKey: SUBJECTS_KEY)
}

func editSubject(_ replaceSubject: Subject) {
    let defaults = UserDefaults.standard
    var subjArray = readSubject()
    for (index,subject) in subjArray.enumerated() {
        if subject.subjectName == replaceSubject.subjectName {
            subjArray[index] = replaceSubject
            break
        }
    }
    defaults.set(try? PropertyListEncoder().encode(subjArray), forKey: SUBJECTS_KEY)
}

/// Clears subjects
func clearSubject() {
    let defaults = UserDefaults.standard
    let arr: [Subject] = []
    defaults.set(try? PropertyListEncoder().encode(arr), forKey: SUBJECTS_KEY)
}
