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
    @State var resultScreen = "test"
    
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
                     CalcButton(displayName: "C", funcType: .symbol, symbolType: .clear),
                     CalcButton(displayName: "=", funcType: .symbol, symbolType: .equal),
                     CalcButton(displayName: "+", funcType: .symbol, symbolType: .plus)]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            Spacer()
            Text(resultScreen)
                .font(.largeTitle)
            Spacer()
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach((0..<inputItem.count), id: \.self) { index in
                    Text(inputItem[index].displayName)
                        .frame(width: 60, height: 60)
                        .background(Color.yellow)
                        .onTapGesture {
                            calculationFor(item: inputItem[index])
                        }
                }
            }
            .padding()
        }
    }
    
    func calculationFor(item: CalcButton) {
        switch item.funcType {
        case .number:
            self.resultScreen += item.displayName
        case .symbol:
            
            switch item.symbolType {
            case .plus:
                self.resultScreen += item.displayName
            case .minus:
                self.resultScreen += item.displayName
            case .times:
                self.resultScreen += item.displayName
            case .divide:
                self.resultScreen += item.displayName
            case.equal:
                self.resultScreen += item.displayName
            case.clear:
                self.resultScreen = ""
            case .none:
                fatalError()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
