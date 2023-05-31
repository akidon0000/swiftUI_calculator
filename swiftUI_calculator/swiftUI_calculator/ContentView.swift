//
//  ContentView.swift
//  swiftUI_calculator
//
//  Created by Akihiro Matsuyama on 2023/05/30.
//

import SwiftUI

struct CalcButton {
    let displayName: String
    let funcType: FuncType
    var number: Int? = nil
    var symbolType: SymbolType? = nil
    
    enum FuncType {
        case number
        case symbol
    }
    enum SymbolType {
        case plus
        case minus
        case times
        case divide
        case clear
        case equal
    }
}

struct ContentView: View {
    @State var resultScreen = "test" // Textの内容を保存する変数
    
    let inputItem = [CalcButton(displayName: "9", funcType: .number, number: 9),
                     CalcButton(displayName: "8", funcType: .number, number: 8),
                     CalcButton(displayName: "7", funcType: .number, number: 7),
                     CalcButton(displayName: "÷", funcType: .symbol, symbolType: .divide),
                     
                     CalcButton(displayName: "6", funcType: .number, number: 6),
                     CalcButton(displayName: "5", funcType: .number, number: 5),
                     CalcButton(displayName: "4", funcType: .number, number: 4),
                     CalcButton(displayName: "×", funcType: .symbol, symbolType: .times),
                     
                     CalcButton(displayName: "3", funcType: .number, number: 3),
                     CalcButton(displayName: "2", funcType: .number, number: 2),
                     CalcButton(displayName: "1", funcType: .number, number: 1),
                     CalcButton(displayName: "-", funcType: .symbol, symbolType: .minus),
                     
                     CalcButton(displayName: "0", funcType: .number, number: 0),
                     CalcButton(displayName: "C", funcType: .number, symbolType: .clear),
                     CalcButton(displayName: "=", funcType: .number, symbolType: .equal),
                     CalcButton(displayName: "+", funcType: .symbol, symbolType: .plus)]
    
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
                ForEach((0..<inputItem.count), id: \.self) { index in
                    // それぞれの要素はTextとします
                    Text(inputItem[index].displayName)
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
