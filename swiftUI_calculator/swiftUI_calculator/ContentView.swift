//
//  ContentView.swift
//  swiftUI_calculator
//
//  Created by Akihiro Matsuyama on 2023/05/30.
//

import SwiftUI

enum CalculateState {
    case initial, addtion, substraction, division, multiplication, sum
}

struct ContentView: View {

    @State var selectedItem: String = "0" //値が変わったらView更新
    @State var calculateNumber: Double = 0
    @State var calculateState: CalculateState = .initial
    private let calculateItems: [[String]] = [  //多次元配列なので
        ["AC", "+/-", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="],
    ]


    var body: some View {

            ZStack {
                Color.black
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    
                    HStack{
                        Spacer()

                        Text(selectedItem == "0" ? checkDecimal(number: calculateNumber) : selectedItem)
                            .font(.system(size: 100, weight: .light))
                            .foregroundColor(Color.white)
                            .padding()
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)//文字が入るように動的に大きさを小さくする
                    }

                VStack{
                    ForEach(calculateItems, id: \.self) { items in
                        NumberView(selectedItem: $selectedItem, calculateNumber: $calculateNumber, calculateState: $calculateState, items: items)
                        //Bindingで渡すとき$つける
                    }
                }
            }
             .padding(.bottom, 40)
        }
    }
    //小数点以下がない時は表示しない
    private func checkDecimal(number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1).isLess(than: .ulpOfOne) {
            return String(Int(number))
        } else {
            return String(number)

        }
    }
}
struct NumberView: View {

    @Binding var selectedItem: String
    @Binding var calculateNumber: Double
    @Binding var calculateState: CalculateState
    
    var items: [String]
    //横幅を4等分するボタンごとの間隔10あけるので50を引く
    private let buttonWidth: CGFloat = (UIScreen.main.bounds.width - 50) / 4
    private let numbers:[String] = ["1", "2", "3","4", "5", "6","7", "8", "9","0", "."]
    private let symbols: [String] = ["÷","×","-","+","="]

    var body: some View {
        HStack{
            ForEach(items, id: \.self) { item in
                Button {
                    handleButtonInfo(item: item)
                } label: {
                    Text(item)
                        .font(.system(size: 30, weight: .regular))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                .foregroundColor(numbers.contains(item) || symbols.contains(item) ? .white : .black)
                .background(handleButtonColor(item: item))
                .frame(width: item == "0" ? buttonWidth * 2 + 10 : buttonWidth)
                .cornerRadius(buttonWidth)
            }
            .frame(height: buttonWidth)
        }
    }

    //ボタンの色を変更
    private func handleButtonColor(item: String) -> Color {
        if numbers.contains(item) {
            return Color(white: 0.2, opacity: 1)
        } else if symbols.contains(item) {
            return Color.orange
        } else {
            return Color(white: 0.8, opacity: 1)
        }
    }
//ボタンタップ時の処理を作成
    private func handleButtonInfo(item: String) {

        //数字が入力された時
        if numbers.contains(item) {
            //.が入力されて、かつ入力済みの値に.が含まれるもしくは0の場合は追加しない
            if item == "." && (selectedItem.contains(".") || selectedItem.contains("0")) {
                return
            }
            if selectedItem.count >= 10 {
                return
            }

            if selectedItem == "0" {
                selectedItem = item
                return
            }

            selectedItem += item
        } else if item == "AC" {
            selectedItem = "0"
            calculateNumber = 0
            calculateState = .initial
        }
        guard let selectedNumber = Double(selectedItem) else { return }
        //計算記号が入力された時
        if item == "÷" {
            setCalculate(state: .division, selectedNumber: selectedNumber)
        } else if item == "×" {
            setCalculate(state: .multiplication, selectedNumber: selectedNumber)
        } else if item == "-" {
            setCalculate(state: .substraction, selectedNumber: selectedNumber)
        } else if item == "+" {
            setCalculate(state: .addtion, selectedNumber: selectedNumber)
        } else if item == "=" {
            selectedItem = "0"
            calculate(selectedNumber: selectedNumber)
            calculateState = .sum
        }
    }
    private func setCalculate(state: CalculateState, selectedNumber: Double) {
        if selectedItem == "0" {
            calculateState = state
            return
        }
        selectedItem = "0"
        calculateState = state
        calculate(selectedNumber: selectedNumber)
    }
    private func calculate(selectedNumber: Double) {
        if calculateNumber == 0 {
            calculateNumber = selectedNumber
            return
        }
        switch calculateState {

        case .addtion:
            calculateNumber = calculateNumber + selectedNumber
        case .substraction:
            calculateNumber = calculateNumber - selectedNumber
        case .division:
            calculateNumber = calculateNumber / selectedNumber
        case .multiplication:
            calculateNumber = calculateNumber * selectedNumber
        default:
            break

        }
    }
}

        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }

