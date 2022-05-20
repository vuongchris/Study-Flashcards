//
//  SubjectModel.swift
//  Study Flashcards
//
//  Created by Ronan Konstantin on 20/05/22.
//

import Foundation

struct Subject: Identifiable, Codable {
    var id = UUID()
    var subjectName: String
    var cards: [Card]
}

let SUBJECTS_KEY = "subjectKey"

/// Writes into highscore user defaults
func writeSubject(_ subject: Subject) {
    let defaults = UserDefaults.standard
    var subjArray = readSubject()
    subjArray.append(subject)
    defaults.set(try? PropertyListEncoder().encode(subjArray), forKey: SUBJECTS_KEY)
}

/// Reads from highscore user defaults
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

/// Clears the leaderboard
func clearSubject() {
    let defaults = UserDefaults.standard
    let arr: [Subject] = []
    defaults.set(try? PropertyListEncoder().encode(arr), forKey: SUBJECTS_KEY)
}
