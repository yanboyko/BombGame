import SwiftUI

@main
struct BombGameApp: App {
    
    @StateObject private var animationViewModel = AnimationViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(), gameViewModel: GameViewModel())
                .environmentObject(animationViewModel)
        }
    }
}
