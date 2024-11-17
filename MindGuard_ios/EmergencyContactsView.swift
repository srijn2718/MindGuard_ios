import SwiftUI

struct EmergencyContactsView: View {
    @State private var contacts: [EmergencyContact] = []
    @State private var isLoading = true
    @State private var showAddContactView = false

    let currentUserId = "currentUserId" // Replace with the actual logged-in user's ID

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading contacts...")
                } else {
                    List(contacts) { contact in
                        Button(action: {
                            callNumber(contact.phoneNumber)
                        }) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(contact.name)
                                        .font(.headline)
                                    Text(contact.phoneNumber)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Image(systemName: "phone.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }

                Button(action: {
                    showAddContactView = true
                }) {
                    Text("Add Contact")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .onAppear {
                fetchContacts()
            }
            .sheet(isPresented: $showAddContactView) {
                AddEmergencyContactView(userId: currentUserId)
            }
            .navigationTitle("Emergency Contacts")
        }
    }

    /// Fetches contacts from Firestore
    func fetchContacts() {
        FirestoreManager.shared.fetchEmergencyContacts(userId: currentUserId) { fetchedContacts, error in
            if let error = error {
                print("Error fetching contacts: \(error.localizedDescription)")
                isLoading = false
                return
            }
            contacts = fetchedContacts ?? []
            isLoading = false
        }
    }

    /// Initiates a phone call to the given number
    func callNumber(_ phoneNumber: String) {
        // Remove spaces, dashes, and special characters
        let formattedNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
                                          .replacingOccurrences(of: "-", with: "")
                                          .replacingOccurrences(of: "(", with: "")
                                          .replacingOccurrences(of: ")", with: "")

        // Ensure the number starts with a "+" for international dialing or is a local number
        guard formattedNumber.hasPrefix("+") || formattedNumber.allSatisfy({ $0.isNumber }) else {
            print("Invalid phone number format.")
            return
        }

        // Create the tel:// URL
        guard let url = URL(string: "tel://\(formattedNumber)"), UIApplication.shared.canOpenURL(url) else {
            print("Cannot open dialer for the given number.")
            return
        }

        UIApplication.shared.open(url)
    }
}
