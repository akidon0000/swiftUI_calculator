//
//  ContentView.swift
//  swiftUI_calculator
//
//  Created by Akihiro Matsuyama on 2023/05/30.
//

import SwiftUI

struct ContentView: View {
    @State var resultScreen = "test" // Textの内容を保存する変数
    
    // グリッドレイアウトの定義
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            Spacer()
            Text(resultScreen) // ボタン入力のモニター
                .font(.largeTitle)
            Spacer()
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach((1...20), id: \.self) { index in
                    // それぞれの要素はTextとします
                    Text("Item \(index)")
                        .frame(width: 60, height: 60)
                        .background(Color.yellow)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
