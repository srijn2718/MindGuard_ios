import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()

    private init() {}

    // MARK: - Fetch Posts
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        db.collection("posts").addSnapshotListener { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            let posts = snapshot?.documents.compactMap { doc -> Post? in
                let data = doc.data()
                return Post(
                    id: doc.documentID,
                    userId: data["userId"] as? String ?? "",
                    content: data["content"] as? String ?? "",
                    likes: data["likes"] as? Int ?? 0
                )
            }
            completion(posts, nil)
        }
    }

    // MARK: - Add Post
    func addPost(_ post: Post, completion: @escaping (Error?) -> Void) {
        let postData: [String: Any] = [
            "userId": post.userId,
            "content": post.content,
            "likes": post.likes
        ]
        db.collection("posts").document(post.id).setData(postData, completion: completion)
    }
    func likePost(postId: String, currentLikes: Int, completion: @escaping (Error?) -> Void) {
        db.collection("posts")
            .document(postId)
            .updateData(["likes": currentLikes + 1], completion: completion)
    }
    // Fetch Comments
    // Fetch Comments with Real-Time Listener
    func fetchComments(for postId: String, completion: @escaping ([Comment]?, Error?) -> Void) {
        db.collection("posts")
            .document(postId)
            .collection("comments")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }

                let comments = snapshot?.documents.compactMap { doc -> Comment? in
                    let data = doc.data()
                    return Comment(
                        id: doc.documentID,
                        userId: data["userId"] as? String ?? "",
                        text: data["text"] as? String ?? ""
                    )
                }
                completion(comments, nil)
            }
    }

    // Add Comment to Firestore
    func addComment(to postId: String, comment: Comment, completion: @escaping (Error?) -> Void) {
        let commentData: [String: Any] = [
            "userId": comment.userId,
            "text": comment.text
        ]
        db.collection("posts")
            .document(postId)
            .collection("comments")
            .addDocument(data: commentData, completion: completion)
    }
    
    func fetchEmergencyContacts(userId: String, completion: @escaping ([EmergencyContact]?, Error?) -> Void) {
            db.collection("emergencyContacts")
                .whereField("userId", isEqualTo: userId)
                .addSnapshotListener { snapshot, error in
                    if let error = error {
                        completion(nil, error)
                        return
                    }

                    let contacts = snapshot?.documents.compactMap { doc -> EmergencyContact? in
                        let data = doc.data()
                        return EmergencyContact(
                            id: doc.documentID,
                            userId: data["userId"] as? String ?? "",
                            name: data["name"] as? String ?? "",
                            phoneNumber: data["phoneNumber"] as? String ?? ""
                        )
                    }
                    completion(contacts, nil)
                }
        }

        // Add Emergency Contact
        func addEmergencyContact(_ contact: EmergencyContact, completion: @escaping (Error?) -> Void) {
            let contactData: [String: Any] = [
                "userId": contact.userId,
                "name": contact.name,
                "phoneNumber": contact.phoneNumber
            ]
            db.collection("emergencyContacts").addDocument(data: contactData, completion: completion)
        }
    }
