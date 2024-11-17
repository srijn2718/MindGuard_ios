import SwiftUI

struct AddEmergencyContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var phoneNumber = ""
    let userId: String

    var body: some View {
        VStack {
            Text("Add Emergency Contact")
                .font(.headline)
                .padding()

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Phone Number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: saveContact) {
                Text("Save")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            .disabled(name.isEmpty || phoneNumber.isEmpty)
        }
        .padding()
    }

    func saveContact() {
        let newContact = EmergencyContact(
            id: UUID().uuidString, // Firestore will generate the ID
            userId: userId,
            name: name,
            phoneNumber: phoneNumber
        )

        FirestoreManager.shared.addEmergencyContact(newContact) { error in
            if let error = error {
                print("Error saving contact: \(error.localizedDescription)")
                return
            }
            // Dismiss the view
            presentationMode.wrappedValue.dismiss()
        }
    }
}
