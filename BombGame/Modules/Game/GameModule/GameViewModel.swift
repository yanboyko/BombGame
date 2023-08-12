import Foundation
import AVFoundation

final class GameViewModel: ObservableObject {
    private var defaults = UserDefaults.standard
    @Published var timerValue = 0
    @Published var isGameOnPause = false
    @Published var timerEnded = false
    
    var backgroundAudioPlayer: AVAudioPlayer?
    var tickAudioPlayer: AVAudioPlayer?

    @Published var currentGame: GameModel?

    var isFreshGame: Bool
    
    var settings: SettingsModel?

    init(
        isFreshGame: Bool,
        currentGame: GameModel?
    ) {
        self.isFreshGame = isFreshGame
        self.currentGame = currentGame
        
        setupSettings()
    }
    
    private func setupSettings() {
        settings = loadSettings()
    }
    
    private func loadSettings() -> SettingsModel? {
        if let savedData = defaults.data(forKey: "settings") {
            if let settings = try? JSONDecoder().decode(SettingsModel.self, from: savedData) {
                return settings
            }
        }
        
        return nil
    }

    func updateGame() {
        timerEnded = false
        timerValue = settings?.time.rawValue ?? 20
        if isFreshGame {
            setRandomQuestion()
            return
        }
        
        if let savedGame = fetchSavedGame() {
            currentGame = savedGame
            timerValue = savedGame.timeLeft
        } else {
            setRandomQuestion()
            return
        }
    }
    
    func setRandomQuestion()  {
        if currentGame != nil {
            self.currentGame?.currentQuestion = QuizQuestion.getRandomQuestion(categories: fetchCategories())
        } else {
            currentGame = GameModel(
                currentQuestion: QuizQuestion.getRandomQuestion(categories: fetchCategories()),
                timeLeft: settings?.time.rawValue ?? 20
            )
        }
    }
    
    private func fetchCategories() -> [QuestionsBox.CategoryName] {
        if let decoded = UserDefaults.standard.data(forKey: "SelectedCategories") {
            if let categories = try? JSONDecoder().decode([QuestionsBox.CategoryName].self, from: decoded) {
                return categories
            }
        }

        return []
    }
    
    func explousionSound() {
        guard let settings else {
            return
        }
        
        let explousionBlast: URL?
        
        switch settings.explosionBomb {
        case .explosionOne:
            explousionBlast = Bundle.main.url(forResource: "Взрыв 1", withExtension: "mp3")
        case .explosionTwo:
            explousionBlast = Bundle.main.url(forResource: "Взрыв 2", withExtension: "mp3")
        case .explosionThree:
            explousionBlast = Bundle.main.url(forResource: "Взрыв 3", withExtension: "mp3")
        }
        
        guard let explousionBlast else {
            return
        }
        
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf: explousionBlast)
            tickAudioPlayer?.stop()
            backgroundAudioPlayer?.play()
        } catch {
            print("Failed to play ending music: \(error.localizedDescription)")
        }
    }
    
    func pauseGame() {
        guard let currentGame else {
            fatalError()
        }
        saveGame(currentGame)
        isGameOnPause.toggle()

        if !isGameOnPause {
            startGame()
        } else {
            stopGame()
        }
    }
    
    func playBackgroundMusic() {
        guard let settings else {
            return
        }
        
        let backGroundMusic: URL?
        
        switch settings.backgroundMusicType {
        case .melodyOne:
            backGroundMusic = Bundle.main.url(forResource: "Мелодия 1", withExtension: "mp3")
        case .melodyTwo:
            backGroundMusic = Bundle.main.url(forResource: "Мелодия 2", withExtension: "mp3")
        case .melodyThree:
            backGroundMusic = Bundle.main.url(forResource: "Мелодия 3", withExtension: "mp3")
        }
        
        guard let backGroundMusic else {
            return
        }
        
        do {
            if settings.isBackgroundMusic {
                backgroundAudioPlayer = try AVAudioPlayer(contentsOf: backGroundMusic)
                backgroundAudioPlayer?.play()
            }
        } catch {
            print("Failed to play background music: \(error.localizedDescription)")
        }
    }
    
    func playTickSound() {
        guard let settings else {
            return
        }
        
        let tickMusic: URL?
        
        switch settings.tickingBomb {
        case .tickOne:
            tickMusic = Bundle.main.url(forResource: "Часы 1", withExtension: "mp3")
        case .tickTwo:
            tickMusic = Bundle.main.url(forResource: "Часы 2", withExtension: "mp3")
        case .tickThree:
            tickMusic = Bundle.main.url(forResource: "Часы 3", withExtension: "mp3")
        }
        
        guard let tickMusic else {
            return
        }
        
        do {
            tickAudioPlayer = try AVAudioPlayer(contentsOf: tickMusic)
            tickAudioPlayer?.play()
        } catch {
            print("Failed to play background music: \(error.localizedDescription)")
        }
    }

    func gameViewDissapear() {
        guard let currentGame else { return }
        saveGame(currentGame)
        isGameOnPause = false
        stopGame()
        self.currentGame = nil
    }

    private func saveGame(_ game: GameModel) {
        if let encodedGame = try? JSONEncoder().encode(game) {
            UserDefaults.standard.set(encodedGame, forKey: "SavedGame")
        }
    }

    private func fetchSavedGame() -> GameModel? {
        if let savedData = UserDefaults.standard.data(forKey: "SavedGame") {
            if let game = try? JSONDecoder().decode(GameModel.self, from: savedData) {
                return game
            }
        }

        return nil
    }
    
    
    private var timer: Timer? // Таймер для обратного отсчета

    func prepareGame() {
        if isFreshGame {
            setRandomQuestion()
        } else if let savedGame = fetchSavedGame() {
            currentGame = savedGame
            timerValue = savedGame.timeLeft
        } else {
            setRandomQuestion()
        }
    }
    
    private func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timerValue > 0 {
                self.timerValue -= 1
                self.backgroundAudioPlayer?.play()
                self.tickAudioPlayer?.play()
            } else {
                self.backgroundAudioPlayer?.stop()
                self.tickAudioPlayer?.stop()
                self.stopGame()
                self.explousionSound()
                self.timerEnded = true
            }
            self.currentGame?.timeLeft = self.timerValue
        }
    }

    func startGame() {
        guard !isGameOnPause else { return }
        configureTimer()
    }

    func initilizeGame() {
        if currentGame == nil {
            prepareGame()
        }
        timerValue = currentGame?.timeLeft ?? 20
        playBackgroundMusic()
        playTickSound()
        startGame()
    }

    func stopGame() {
        backgroundAudioPlayer?.pause()
        tickAudioPlayer?.pause()
        timer?.invalidate()
        timer = nil
    }
    
}

