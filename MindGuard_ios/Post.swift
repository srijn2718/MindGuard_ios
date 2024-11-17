import Foundation

struct Post: Identifiable {
    let id: String
    let userId: String
    let content: String
    var likes: Int
    var comments: [Comment] = []
}
