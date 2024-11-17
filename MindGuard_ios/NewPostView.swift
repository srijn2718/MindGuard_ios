import SwiftUI

struct NewPostView: View {
    @State private var content = "" // Content of the new post
    @Environment(\.presentationMode) var presentationMode // Dismiss control

    var body: some View {
        VStack {
            Text("Create a New Post")
                .font(.headline)
                .padding()

            TextField("What's on your mind?", text: $content)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: addPost) {
                Text("Post")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            .disabled(content.isEmpty) // Disable the button if content is empty
        }
        .padding()
    }

    func addPost() {
        let newPost = Post(
            id: UUID().uuidString,
            userId: "currentUserId", // Replace with the actual user ID
            content: content,
            likes: 0
        )

        FirestoreManager.shared.addPost(newPost) { error in
            if let error = error {
                print("Error adding post: \(error.localizedDescription)")
                return
            }
            // Dismiss the sheet
            presentationMode.wrappedValue.dismiss()
        }
    }
}
