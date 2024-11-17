import SwiftUI

struct DASS21QuestionnaireView: View {
    // Sample questions
    let questions = [
        "I found it hard to wind down.",
        "I was aware of dryness of my mouth.",
        "I couldn’t seem to experience any positive feeling at all.",
        "I experienced breathing difficulty (eg, excessively rapid breathing, breathlessness in the absence of physical exertion)",
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
        "I felt that life was meaningless"
    ]
    
    // Stores selected answers for each question
    @State private var answers = Array(repeating: 0, count: 21)
    
    // Calculate the scores for depression, anxiety, and stress
    func calculateScores() -> (depression: Int, anxiety: Int, stress: Int) {
        var depressionScore = 0
        var anxietyScore = 0
        var stressScore = 0
        
        // Depression: questions: 2, 4, 9, 12, 15, 16, 20
        // Anxiety: questions: 2, 4, 7, 9, 15, 19, 20
        // Stress: other questions
        
        for (index, answer) in answers.enumerated() {
            switch answer {
            case 1:
                let score = 1
                if [2, 4, 9, 12, 15, 16, 20].contains(index) {
                    depressionScore += score
                } else if [2, 4, 7, 9, 15, 19, 20].contains(index) {
                    anxietyScore += score
                } else {
                    stressScore += score
                }
            case 2:
                let score = 2
                if [2, 4, 9, 12, 15, 16, 20].contains(index) {
                    depressionScore += score
                } else if [2, 4, 7, 9, 15, 19, 20].contains(index) {
                    anxietyScore += score
                } else {
                    stressScore += score
                }
            case 3:
                let score = 3
                if [2, 4, 9, 12, 15, 16, 20].contains(index) {
                    depressionScore += score
                } else if [2, 4, 7, 9, 15, 19, 20].contains(index) {
                    anxietyScore += score
                } else {
                    stressScore += score
                }
            default:
                break
            }
        }
        
        return (depressionScore, anxietyScore, stressScore)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Questionnaire")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 20)
                    
                    // Loop through the questions and display a Picker for each
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
                    
                    // NavigationLink to Results view
                    NavigationLink(
                        destination: DASS21ResultsView(
                            depressionScore: calculateScores().depression,
                            anxietyScore: calculateScores().anxiety,
                            stressScore: calculateScores().stress
                        )
                    ) {
                        Text("Submit")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 30)
                    .disabled(answers.contains(0)) // Disable the button if any answer is missing
                }
                .padding()
            }
            .navigationTitle("DASS-21")
        }
    }
}
