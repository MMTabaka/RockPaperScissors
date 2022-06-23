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
                    Text("Win")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Text("👊")
                        .handIcon()
                }
                Spacer()
                Spacer()
                Spacer()
                HStack(spacing: 5) {
                    Button {
                        // action
                    } label: {
                        Text("👊")
                            .handIcon()
                    }
                    
                    Button {
                        // action
                    } label: {
                        Text("🤚")
                            .handIcon()
                    }
                    
                    Button {
                        // action
                    } label: {
                        Text("✌️")
                            .handIcon()
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
