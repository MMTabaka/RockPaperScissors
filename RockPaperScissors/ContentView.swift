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
            .font(.system(size: 90))
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
    @State private var showingEnd = false
    let rules = ["👊": "🤚", "🤚": "✌️", "✌️": "👊"]
    let moves = ["👊", "🤚", "✌️"]
    @State private var opponent = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var score = 0
    let numOfGames = 4
    @State private var currentGame = 1
    
    
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            Text(currentGame, format: .number)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .foregroundColor(.white)
            
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
                        .frame(width: 110 , height: 110)
                        .background(.white)
                        .clipShape(Circle())
                }
                Spacer()
                Spacer()
                
                Text("\(score)/\(numOfGames)")
                    .font(.title2)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 20) {
                    ForEach(moves, id: \.self) { move in
                        Button {
                            moveTapped(move)
                        } label: {
                            Text(move)
                                .handIcon()
                                .shadow(color: .black, radius: 20)
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
        .alert(scoreTitle, isPresented: $showingEnd) {
            Button("Play again") {
                reset()
            }
        } message: {
            Text("Your score: \(score)/\(numOfGames)")
        }
        
    }
    
    func moveTapped(_ move: String) {
        let opponentMove = moves[opponent]
        
        if mode {
            scoreTitle = rules[opponentMove] == move ? "Correct" : "Incorrect. The answer was \(move)"
        } else {
            scoreTitle = rules[move] == opponentMove ? "Correct" : "Incorrect. The answer was \(move)"
        }
        
        if scoreTitle == "Correct" {
            score += 1
        }
        
        
        if currentGame == numOfGames {
            showingEnd = true
        } else {
            showingResult = true
        }
    }
    
    func play() {
        currentGame += 1
        mode.toggle()
        opponent = Int.random(in: 0...2)
    }
    
    func reset() {
        mode = true
        opponent = Int.random(in: 0...2)
        currentGame = 1
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
