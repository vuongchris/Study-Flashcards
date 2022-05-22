//
//  FlipAnimation.swift
//  Study Flashcards
//
//  The code for this animation was sourced from a Youtube tutorial
//  https://github.com/SamuelDo02/swiftuitutorials/blob/main/Flashcard.swift
//  https://www.youtube.com/watch?v=v2Xf1gwcQSA
//

import Foundation
import UIKit
import SwiftUI

class FlashCardData: ObservableObject {
    @Published var cardIndex: Int = 0
    var flipped: Bool = false
}

struct ContentView: View {
    let subject: Subject
    let cardList: [Card]
    
    @State private var question: String
    @State private var answer: String
    @ObservedObject var data: FlashCardData = FlashCardData()
    
    init(subject: Subject) {
        self.subject = subject
        self.cardList = subject.cards
        if cardList.isEmpty {
            self.question = "Please add a card for this subject"
            self.answer = "Please add a card for this subject"
        }
        else {
            self.question = cardList[0].question
            self.answer = cardList[0].answer
        }
    }
    
    var body: some View {
        Flashcard(front: {
            Text(question)
        }, back: {
            Text(answer)
        },
            flipped: self.$data.flipped
        )
        HStack (spacing: 20) {
            Button(action: {
                if self.data.cardIndex > 0 {
                    self.data.cardIndex -= 1
                    updateQuestion()
                }
            }) {
                Text("Previous")
            }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 150, height: 50)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                .foregroundColor(Color.white)
                .font(.title2)
                .padding()
            
            Button(action: {
                if self.data.cardIndex + 1 < cardList.count {
                    self.data.cardIndex += 1
                    updateQuestion()
                }
            }) {
                Text("Next")
            }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 150, height: 50)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                .foregroundColor(Color.white)
                .font(.title2)
                .padding()
        }
    }
    
    func updateQuestion() {
        data.flipped = false
        question = cardList[data.cardIndex].question
        answer = cardList[data.cardIndex].answer
    }
}

struct Flashcard<Front, Back>: View where Front: View, Back: View {
    var front: () -> Front
    var back: () -> Back
    
    @Binding var flipped: Bool
    
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
        
    var body: some View {
        ZStack {
            if flipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
        .padding()
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .foregroundColor(Color.black)
        .overlay(
            Rectangle()
                .stroke(Color.black, lineWidth: 2)
        )
        .padding()
        .onTapGesture {
            flipFlashcard()
        }
        .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
    }
    
    func flipFlashcard() {
        let animationTime = 0.5
        withAnimation(Animation.linear(duration: animationTime)) {
                   flashcardRotation += 180
               }
               
               withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
                   contentRotation += 180
                   flipped.toggle()
               }
        
    }
}
