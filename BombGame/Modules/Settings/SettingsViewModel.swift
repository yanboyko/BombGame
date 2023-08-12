import Foundation

enum TextStackOptions {
    case selectedMusic
    case selectedTickingBomb
    case selectedExplosionBomb
}

enum TimeButtonType: Codable {
    case short
    case average
    case long
    case random
}

enum MusicType: String, CaseIterable, Codable {
    case melodyOne = "Мелодия 1"
    case melodyTwo = "Мелодия 2"
    case melodyThree = "Мелодия 3"
}

enum TickingBombMusicType: String, CaseIterable, Codable {
    case tickOne = "Часы 1"
    case tickTwo = "Часы 2"
    case tickThree = "Часы 3"
}

enum ExplosionBombMusicType: String, CaseIterable, Codable {
    case explosionOne = "Взрыв 1"
    case explosionTwo = "Взрыв 2"
    case explosionThree = "Взрыв 3"
}

struct SettingsModel: Codable {
    let time: TimeButtonType
    let isTask: Bool
    let isBackgroundMusic: Bool
    let backgroundMusicType: MusicType
    let tickingBomb: TickingBombMusicType
    let explosionBomb: ExplosionBombMusicType
    let isAnimation: Bool
}

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var isTask = true
    @Published var isBackgroundMusic = true
    @Published var isAnimation = false
    @Published var selectedTimeButton: TimeButtonType = .short
    @Published var selectedMusic: MusicType = .melodyOne
    @Published var selectedTickingBomb: TickingBombMusicType = .tickOne
    @Published var selectedExplosionBomb: ExplosionBombMusicType = .explosionOne
    
    let defaults = UserDefaults.standard
    
    func saveSettings() {
        let settings = SettingsModel(
            time: selectedTimeButton,
            isTask: isTask,
            isBackgroundMusic: isBackgroundMusic,
            backgroundMusicType: selectedMusic,
            tickingBomb: selectedTickingBomb,
            explosionBomb: selectedExplosionBomb,
            isAnimation: isAnimation
        )
        
        if let encodedData = try? JSONEncoder().encode(settings) {
            defaults.set(encodedData, forKey: "settings")
        }
    }
    
    func loadSettings() {
        if let savedData = defaults.data(forKey: "settings") {
            if let settings = try? JSONDecoder().decode(SettingsModel.self, from: savedData) {
                print(settings)
                isTask = settings.isTask
                isBackgroundMusic = settings.isBackgroundMusic
                isAnimation = settings.isAnimation
                selectedTimeButton = settings.time
                selectedMusic = settings.backgroundMusicType
                selectedTickingBomb = settings.tickingBomb
                selectedExplosionBomb = settings.explosionBomb
            }
        }
    }
}
