import SwiftUI
import Firebase

@main
struct MindGuard_iosApp: App {
    init() {
        // Initialize Firebase
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            // Start with the SplashScreenView
            SplashScreenView()
        }
    }
}
