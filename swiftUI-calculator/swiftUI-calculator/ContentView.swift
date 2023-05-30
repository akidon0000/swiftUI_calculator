//
//  ContentView.swift
//  swiftUI-calculator
//
//  Created by Bando Takuya on 2023/05/30.
//

import SwiftUI

struct ContentView: View {
    @State var resultScreen = "Hello, world!"
    var body: some View {
        VStack {
            Text(resultScreen)
            Button(action: {
                self.resultScreen = "Button Tapped"
            }) {
                Text("Button")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
