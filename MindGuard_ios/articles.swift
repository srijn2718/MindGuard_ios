import SwiftUI

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let url: String
}

struct WHOArticleScreen: View {
    let articles = [
        Article(title: "Mental Health and COVID-19", description: "How the pandemic affects mental health globally.", url: "https://www.who.int/news-room/feature-stories/detail/mental-health-and-covid-19"),
        Article(title: "Child Mental Health", description: "Understanding and supporting children's mental health.", url: "https://www.who.int/news-room/fact-sheets/detail/mental-health"),
        // Add more articles as needed
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("BG")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(articles) { article in
                            ArticleCardView(article: article)
                                .padding(.horizontal)
                                .onTapGesture {
                                    openURL(article.url)
                                }
                        }
                    }
                    .padding(.vertical)
                }
            }
            
        }
    }
    
    private func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

struct ArticleCardView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(article.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(article.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3) // Trims long descriptions
            
            HStack {
                Spacer()
                Text("Read more")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct WHOArticleScreen_Previews: PreviewProvider {
    static var previews: some View {
        WHOArticleScreen()
    }
}
