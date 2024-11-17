import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var userEmail: String = Auth.auth().currentUser?.email ?? "Unknown"
    @State private var errorMessage: String = ""
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    @State private var navigateToLogin = false

    var body: some View {
        if navigateToLogin {
            LoginView() // Navigate to LoginView after logout
        } else {
            VStack(spacing: 20) {
                Text("Profile")
                    .font(.largeTitle)
                    .bold()

                Text("Email: \(userEmail)")
                    .font(.headline)
                    .padding()

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button(action: logoutUser) {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }

    func logoutUser() {
        do {
            try Auth.auth().signOut()
            navigateToLogin = true
        } catch let error {
            errorMessage = "Failed to log out: \(error.localizedDescription)"
        }
    }
}
