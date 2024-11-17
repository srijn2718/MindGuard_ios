import SwiftUI

struct BackgroundImageScreen: View {
    var body: some View {
        ZStack {
            // Background Image
            Image("ABOUT US IN")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // Optional Blur Effect
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct BackgroundImageScreen_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageScreen()
    }
}
