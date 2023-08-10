import Foundation
import AVFoundation

final class GameViewModel: ObservableObject {
    
    @Published var isGameRunning = false
    @Published var timerValue = 0
    @Published var isMusicPlaying = false
    @Published var isMusicPlayingw = false
    @Published var pauseGame = true
    @Published var timerEnded = false
    
    var audioPlayer: AVAudioPlayer?
    
    func randomQuestion() -> QuizQuestion? {
        return QuizQuestion.quizData.randomElement()
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
    
    func tpauseGame() {
        pauseGame.toggle()
        if pauseGame{
            startGame()
            
        } else{
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
    
    
    private var timer: Timer? // Таймер для обратного отсчета
    
    func startGame() {
        guard !isGameRunning else { return }
        
        isGameRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timerValue > 0 {
                self.timerValue -= 1
                self.audioPlayer?.play()
                self.isMusicPlaying.toggle()
                isMusicPlayingw = false
                
            } else {
                self.audioPlayer?.stop()
                self.isMusicPlaying = false
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

