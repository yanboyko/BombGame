import Foundation

final class MainViewModel: ObservableObject {
    func startGamePressed() {
        print("start game pressed")
    }
    
    func proceedGamePressed() {
        print("proceedGamePressed")
    }
    
    func categoriesPressed() {
        print("categoriesPressed")
    }
    
    func settingsPressed() {
        print("settingsPressed")
    }
    
    func helpPressed() {
        print("settingsPressed")
    }
    
    func fetchSavedGame() -> GameModel? {
        if let savedData = UserDefaults.standard.data(forKey: "SavedGame") {
            if let game = try? JSONDecoder().decode(GameModel.self, from: savedData) {
                
                print(game.timeLeft)
                
                return game
            }
        }

        return nil
    }
}
