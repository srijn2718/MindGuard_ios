import SwiftUI

struct PostDetailView: View {
    @State var post: Post
    @State private var newComment = ""
    @State private var comments: [Comment] = [] // Holds all comments for the post

    var body: some View {
        VStack {
            ScrollView {
                Text(post.content)
                    .font(.headline)
                    .padding()

                Button("Like (\(post.likes))") {
                    likePost()
                }
                .padding()
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)

                Divider()

                Text("Comments")
                    .font(.headline)
                    .padding(.horizontal)

                ForEach(comments) { comment in
                    VStack(alignment: .leading) {
                        Text(comment.text)
                            .font(.body)
                            .padding(.vertical, 5)
                    }
                }
            }

            HStack {
                TextField("Add a comment...", text: $newComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Post") {
                    addComment()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .onAppear {
            fetchComments()
        }
        .navigationTitle("Post Details")
    }

    func fetchComments() {
        FirestoreManager.shared.fetchComments(for: post.id) { fetchedComments, error in
            if let error = error {
                print("Error fetching comments: \(error.localizedDescription)")
                return
            }
            comments = fetchedComments ?? []
        }
    }

    func likePost() {
        FirestoreManager.shared.likePost(postId: post.id, currentLikes: post.likes) { error in
            if let error = error {
                print("Error liking post: \(error.localizedDescription)")
                return
            }
            post.likes += 1
        }
    }

    func addComment() {
        guard !newComment.isEmpty else { return }
        let comment = Comment(id: UUID().uuidString, userId: "currentUserId", text: newComment)

        FirestoreManager.shared.addComment(to: post.id, comment: comment) { error in
            if let error = error {
                print("Error adding comment: \(error.localizedDescription)")
                return
            }
            // No manual update to the comments array here
            newComment = "" // Clear the input field
        }
    }
}
