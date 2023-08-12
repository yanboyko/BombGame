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
    
    func addCategoriesIfNeeded() {
        if let decoded = UserDefaults.standard.data(forKey: "SelectedCategories") {
            if let categories = try? JSONDecoder().decode([QuestionsBox.CategoryName].self, from: decoded) {
                if categories.isEmpty {
                    let newCategories: [QuestionsBox.CategoryName] = [.aboutLife, .artsAndCinema, .celebrities, .miscellaneous, .nature, .sportsAndHobbies]
                    if let encoded = try? JSONEncoder().encode(newCategories) {
                        UserDefaults.standard.set(encoded, forKey: "SelectedCategories")
                    }
                }
            }
        } else {
            let newCategories: [QuestionsBox.CategoryName] = [.aboutLife, .artsAndCinema, .celebrities, .miscellaneous, .nature, .sportsAndHobbies]
            if let encoded = try? JSONEncoder().encode(newCategories) {
                UserDefaults.standard.set(encoded, forKey: "SelectedCategories")
            }
        }
    }
}
