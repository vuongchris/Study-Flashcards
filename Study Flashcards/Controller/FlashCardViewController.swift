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

struct ContentView: View {
    
    var cardList: Set<Card>?
    var number = 0
    
    var body: some View {
        Flashcard(front: {
            Text(cardList![cardList!.index(cardList!.startIndex, offsetBy: 1)].question!)
        }, back: {
            Text(cardList![cardList!.index(cardList!.startIndex, offsetBy: 1)].answer!)
        })
        
        Button("Previous") {}
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .padding()
        
        Button("Next") {}
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .padding()

        

        
}
}

struct Flashcard<Front, Back>: View where Front: View, Back: View {
    var front: () -> Front
    var back: () -> Back
    
    @State var flipped: Bool = false
    
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    
    init(@ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.front = front
        self.back = back
    }
    
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

class FlashCardViewController: UIHostingController<ContentView> {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: ContentView());
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
