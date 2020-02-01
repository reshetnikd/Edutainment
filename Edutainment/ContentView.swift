//
//  ContentView.swift
//  Edutainment
//
//  Created by Dmitry Reshetnik on 01.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfTables = 1
    @State private var numberOfQuestions = 1
    @State private var questions = [5, 10, 15, 144]
    @State private var multiplicationTables = []
    
    var body: some View {
        Form {
            Section(header: Text("Witch multiplication table you want to practice?")) {
                Stepper(value: $numberOfTables, in: 1...12) {
                    Text("Up to \(numberOfTables)")
                }
                
                Picker("How many questions", selection: $numberOfQuestions) {
                    ForEach(0..<questions.count) {
                        if $0 == self.questions.count - 1 {
                            Text("All")
                        } else {
                            Text("\(self.questions[$0])")
                        }
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                Button(action: {
                    self.generateTables(to: self.numberOfTables)
                }) {
                    Text("Play")
                }
            }
        }
    }
    
    func generateTables(to number: Int) {
        let columns = number
        let rows = 12
        
        if number != 1 {
            for column in 1...columns {
                for row in 1...rows {
                    multiplicationTables.append("\(column) x \(row)")
                }
            }
        } else {
            for row in 1...rows {
                multiplicationTables.append("\(number) x \(row)")
            }
        }
        
        for table in multiplicationTables {
            print(table)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
