//
//  DASS21QuestionnaireView.swift
//  MindGuard_ios
//
//  Created by Chitrap Srivastava on 07/11/24.
//


import SwiftUI

struct DASS21QuestionnaireView: View {
    // Sample questions
    let questions = [
        "I found it hard to wind down.",
        "I was aware of dryness of my mouth.",
        "I couldn’t seem to experience any positive feeling at all.",
        "I experienced breathing difficulty (eg, excessively rapid breathing,breathlessness in the absence of physical exertion)",
        "I found it difficult to work up the initiative to do things",
        "I tended to over-react to situations",
        "I experienced trembling (eg, in the hands)",
        "I felt that I was using a lot of nervous energy",
        "I was worried about situations in which I might panic and make a fool of myself",
        "I felt that I had nothing to look forward to",
        "I found myself getting agitated",
        "I found it difficult to relax",
        "I felt down-hearted and blue",
        "I was intolerant of anything that kept me from getting on with what I was doing",
        "I felt I was close to panic",
        "I was unable to become enthusiastic about anything",
        "I felt I wasn't worth much as a person",
        "I felt that I was rather touchy",
        "I was aware of the action of my heart in the absence of physical exertion (eg, sense of heart rate increase, heart missing a beat)",
        "I felt scared without any good reason ",
        "I felt scared without any good reason 21 I felt that life was meaningless"

    ]
    
    // Stores selected answers for each question
    @State private var answers = Array(repeating: 0, count: 21)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Questionnaire")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 20)
                    
                    ForEach(0..<questions.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text("Q\(index + 1): \(questions[index])")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            Picker(selection: $answers[index], label: Text("Choose an option")) {
                                Text("0").tag(0)
                                Text("1").tag(1)
                                Text("2").tag(2)
                                Text("3").tag(3)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding(.bottom, 15)
                    }
                    
                    Button(action: submitAnswers) {
                        Text("Submit")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 30)
                }
                .padding()
            }
            .navigationTitle("DASS-21")
        }
    }
    
    func submitAnswers() {
        // Handle submission of answers here
        print("Answers submitted:", answers)
    }
}
#Preview {
    DASS21QuestionnaireView()
}
