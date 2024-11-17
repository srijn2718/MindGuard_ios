import SwiftUI

struct DASS21ResultsView: View {
    var depressionScore: Int
    var anxietyScore: Int
    var stressScore: Int
    
    func severity(for score: Int) -> String {
        switch score {
        case 0...9:
            return "Normal"
        case 10...13:
            return "Mild"
        case 14...20:
            return "Moderate"
        case 21...27:
            return "Severe"
        case 28...:
            return "Very Severe"
        default:
            return "Invalid"
        }
    }
    
    var body: some View {
        VStack {
            Text("DASS-21 Results")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Depression Score: \(depressionScore)")
                    .font(.title2)
                Text("Severity: \(severity(for: depressionScore))")
                    .font(.subheadline)
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Anxiety Score: \(anxietyScore)")
                    .font(.title2)
                Text("Severity: \(severity(for: anxietyScore))")
                    .font(.subheadline)
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Stress Score: \(stressScore)")
                    .font(.title2)
                Text("Severity: \(severity(for: stressScore))")
                    .font(.subheadline)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Results")
    }
}

#Preview {
    DASS21ResultsView(depressionScore: 15, anxietyScore: 12, stressScore: 8)
}
