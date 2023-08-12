import Foundation
import AVFoundation

final class GameViewModel: ObservableObject {
    
    @Published var isGameRunning = false
    @Published var timerValue = 0
    @Published var backGroundMusicPlaying = false
    @Published var explousionBlasting = false
    @Published var pauseGame = true
    @Published var timerEnded = false
    
    var audioPlayer: AVAudioPlayer?
    
    func randomQuestion() -> QuizQuestion? {
        return QuizQuestion.quizData.randomElement()
    }
    
    func explousionSound() {
        guard let explousionBlast = Bundle.main.url(forResource: "Взрыв 1", withExtension: "mp3") else {
            print("Failed to find the ending music file.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: explousionBlast)
            audioPlayer?.play()
            explousionBlasting = true
        } catch {
            print("Failed to play ending music: \(error.localizedDescription)")
        }
    }
    
    func pausingGame() {
        pauseGame.toggle()
        if pauseGame{
            startGame()
            
        } else{
            stopGame()
        }
        
    }
    
    
    
    func playBackgroundMusic() {
        guard let backGroundMusic = Bundle.main.url(forResource: "Мелодия 1", withExtension: "mp3") else {
            print("Failed to find the background music file.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: backGroundMusic)
            audioPlayer?.play()
            backGroundMusicPlaying = true
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
                self.backGroundMusicPlaying.toggle()
                explousionBlasting = false
                
            } else {
                self.audioPlayer?.stop()
                self.backGroundMusicPlaying = false
                stopGame()
                if !self.explousionBlasting {
                    self.explousionSound()
                    self.explousionBlasting = true
                    self.timerEnded = true
                   
                    
                }
               
            }
        }
    }
    func stopGame() {
        audioPlayer?.pause()
        backGroundMusicPlaying = false
        timer?.invalidate()
        timer = nil
        isGameRunning = false
    }
    
}

