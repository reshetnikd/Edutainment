//
//  ContentView.swift
//  Edutainment
//
//  Created by Dmitry Reshetnik on 01.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    struct Question {
        let text: String
        let answer: String
    }
    
    @State private var numberOfTables = 1
    @State private var numberOfQuestions = 1
    @State private var questions = [5, 10, 15, 144]
    @State private var multiplicationTables = [Question]()
    @State private var isShowingQuestions = false
    @State private var answers = [String]()
    @State private var correctAnswers = 0
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    if !isShowingQuestions {
                        Section(header: Text("Witch multiplication tables?")) {
                            Stepper(value: $numberOfTables, in: 1...12) {
                                Text("Up to \(numberOfTables)")
                            }
                        }
                        
                        Section(header: Text("How many questions?")) {
                            Picker("How many questions", selection: $numberOfQuestions) {
                                if numberOfTables > 1 {
                                    ForEach(0..<questions.count) {
                                        if $0 == self.questions.count - 1 {
                                            Text("All")
                                        } else {
                                            Text("\(self.questions[$0])")
                                        }
                                    }
                                } else {
                                    ForEach(0..<2) {
                                        Text("\(self.questions[$0])")
                                    }
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    } else {
                        Section(header: Text("Answer the questions.")) {
                            ForEach(0..<self.questions[self.numberOfQuestions]) {
                                TextField("\(self.multiplicationTables[$0].text) =", text: self.$answers[$0])
                                    .keyboardType(.numberPad)
                            }
                        }
                    }
                }
                
                Button(action: {
                    if self.isShowingQuestions {
                        for index in 0..<self.questions[self.numberOfQuestions] {
                            if self.multiplicationTables[index].answer == self.answers[index] {
                                self.correctAnswers += 1
                            }
                        }
                        self.isShowingQuestions.toggle()
                        self.showingAlert = true
                    } else {
                        self.generateTables(to: self.numberOfTables)
                        self.questions[self.questions.count - 1] = self.numberOfTables * 12
                        for _ in 0..<self.questions[self.numberOfQuestions] {
                            self.answers.append("")
                        }
                        self.isShowingQuestions.toggle()
                    }
                }) {
                    if self.isShowingQuestions {
                        Text("Check")
                    } else {
                        Text("Play")
                    }
                }
            }
            .navigationBarTitle("Edutainment")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Your Answer"), message: Text("You give \(correctAnswers) correct answers. Nice job!"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func generateTables(to number: Int) {
        let columns = number
        let rows = 12
        
        if number != 1 {
            for column in 1...columns {
                for row in 1...rows {
                    multiplicationTables.append(Question(text: "\(column) x \(row)", answer: "\(column * row)"))
                }
            }
        } else {
            for row in 1...rows {
                multiplicationTables.append(Question(text: "\(number) x \(row)", answer: "\(number * row)"))
            }
        }
        
        multiplicationTables.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
