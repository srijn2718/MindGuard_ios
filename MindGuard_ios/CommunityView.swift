import SwiftUI

struct CommunityView: View {
    @State private var posts: [Post] = []
    @State private var isLoading = true
    @State private var showNewPostView = false // Controls the modal presentation

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading posts...")
                } else {
                    List(posts) { post in
                        NavigationLink(destination: PostDetailView(post: post)) {
                            PostCardView(post: post)
                        }
                    }
                }

                // Add New Post Button
                Button(action: {
                    showNewPostView = true
                }) {
                    Text("New Post")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .onAppear {
                fetchPosts()
            }
            .sheet(isPresented: $showNewPostView) {
                NewPostView() // No need to pass posts here
            }
            .navigationTitle("Community")
        }
    }

    func fetchPosts() {
        FirestoreManager.shared.fetchPosts { fetchedPosts, error in
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                isLoading = false
                return
            }
            posts = fetchedPosts ?? [] // Fetches posts only once from Firestore
            isLoading = false
        }
    }
}
