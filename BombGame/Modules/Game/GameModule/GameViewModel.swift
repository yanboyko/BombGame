import Foundation
import AVFoundation

final class GameViewModel: ObservableObject {
    
    @Published var isGameRunning = false
    @Published var timerValue = 0
    @Published var isMusicPlaying = false
    @Published var isMusicPlayingw = false
    @Published var isGamePaused = true
    @Published var timerEnded = false
    
    var audioPlayer: AVAudioPlayer?

    @Published var currentGame: GameModel?

    var isFreshGame: Bool

    init(isFreshGame: Bool) {
        self.isFreshGame = isFreshGame
    }

    func updateGame() {
        timerEnded = false
        timerValue = 20
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
            self.currentGame?.currentQuestion = QuizQuestion.getRandomQuestion()
        } else {
            currentGame = GameModel(currentQuestion: QuizQuestion.getRandomQuestion(), timeLeft: 20)
        }
    }
    
    func explousionSound() {
        guard let musicUrlw = Bundle.main.url(forResource: "explousion", withExtension: "wav") else {
            print("Failed to find the ending music file.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicUrlw)
            audioPlayer?.play()
            isMusicPlayingw = true
        } catch {
            print("Failed to play ending music: \(error.localizedDescription)")
        }
    }
    
    func pauseGame() {
        guard let currentGame else {
            fatalError()
        }
        saveGame(currentGame)
        isGamePaused.toggle()

        if isGamePaused {
            startGame()
        } else {
            stopGame()
        }
        
    }
    
    func playBackgroundMusic() {
        guard let musicUrl = Bundle.main.url(forResource: "Audio1", withExtension: "mp3") else {
            print("Failed to find the background music file.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicUrl)
            audioPlayer?.play()
            isMusicPlaying = true
        } catch {
            print("Failed to play background music: \(error.localizedDescription)")
        }
    }

    func gameViewDissapear() {
        guard let currentGame else { return }
        saveGame(currentGame)
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
    
    func startGame() {
        guard !isGameRunning else { return }
        if currentGame == nil {
            prepareGame()
        }
        
        isGameRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timerValue > 0 {
                self.timerValue -= 1
                self.audioPlayer?.play()
                self.isMusicPlaying.toggle()
                self.isMusicPlayingw = false
            } else {
                self.audioPlayer?.stop()
                self.isMusicPlaying = false
                self.stopGame()
                if !self.isMusicPlayingw {
                    self.explousionSound()
                    self.isMusicPlayingw = true
                    self.timerEnded = true
                }
            }
        }
    }

    func stopGame() {
        audioPlayer?.pause()
        isMusicPlaying = false
        timer?.invalidate()
        timer = nil
        isGameRunning = false
    }
    
}

