//
//  ContentView.swift
//  ColorizedAppSwiftUI
//
//  Created by Ivan on 16.05.2022.
//

import SwiftUI

enum Field {
    case red
    case green
    case blue
}

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack(spacing: 20) {
            RectangleView(redValue: redSliderValue, greenValue: greenSliderValue, blueValue: blueSliderValue)
            SliderView(name: "Red", sliderColor: .red, colorValue: $redSliderValue)
                .focused($focusedField, equals: .red)
            SliderView(name: "Green", sliderColor: .green, colorValue: $greenSliderValue)
                .focused($focusedField, equals: .green)
            SliderView(name: "Blue", sliderColor: .blue, colorValue: $blueSliderValue)
                .focused($focusedField, equals: .blue)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Next") {
                    switch focusedField {
                    case .red:
                        focusedField = .green
                    case .green:
                        focusedField = .blue
                    default:
                        focusedField = .red
                    }
                }
            }
        }
        .padding()
        .background(.cyan)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RectangleView: View {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    
    var body: some View {
        Rectangle()
            .fill(Color(red: redValue / 255, green: greenValue / 255, blue: blueValue / 255))
            .cornerRadius(10)
            .frame(height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white, lineWidth: 5)
            )
    }
}


struct SliderView: View {
    let name: String
    let sliderColor: Color
    @Binding var colorValue: Double
    
    var body: some View {
        HStack {
            Text("\(lround(colorValue))")
                .foregroundColor(.white)
                .frame(width: 50, alignment: .leading)
            Slider(value: $colorValue, in: 0...255, step: 1.0)
                .accentColor(sliderColor)
            TextField("", value: $colorValue, format: .number)
                .textContentType(.givenName)
                .submitLabel(.next)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .frame(width: 50, alignment: .trailing)
        }
        
    }
}

