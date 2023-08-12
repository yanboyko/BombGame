import SwiftUI

@main
struct BombGameApp: App {
    
    @StateObject private var animationViewModel = AnimationViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(animationViewModel)
        }
    }
}
