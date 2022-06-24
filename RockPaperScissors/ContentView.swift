//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Milosz Tabaka on 23/06/2022.
//

import SwiftUI


struct HandIconModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100)
            .background(Circle().fill(.white))
            .font(.system(size: 75))
    }
}

extension View {
    func handIcon() -> some View {
        modifier(HandIconModifier())
    }
}

struct ContentView: View {
    @State private var mode: Bool = true
    @State private var showingResult = false
    let rules = ["👊": "🤚", "🤚": "✌️", "✌️": "👊"]
    let moves = ["👊", "🤚", "✌️"]
    @State private var opponent = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    
    
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Rock Paper Scissors")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                VStack {
                    Text(mode ? "WIN" : "LOSE")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Text(moves[opponent])
                        .handIcon()
                }
                Spacer()
                Spacer()
                Spacer()
                HStack(spacing: 5) {
                    ForEach(moves, id: \.self) { move in
                        Button {
                            moveTapped(move)
                        } label: {
                            Text(move)
                                .handIcon()
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingResult) {
            Button("Continue") {
                play()
            }
        }
    }
    
    func moveTapped(_ move: String) {
        let opponentMove = moves[opponent]
        
        if mode {
            scoreTitle = rules[opponentMove] == move ? "Correct" : "Incorrect"
        } else {
            scoreTitle = rules[move] == opponentMove ? "Correct" : "Incorrect"
        }
        
        print(opponentMove)
        showingResult = true
    }
    
    func play() {
        mode.toggle()
        opponent = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
