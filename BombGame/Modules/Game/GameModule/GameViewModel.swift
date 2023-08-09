    

import Foundation
import AVFoundation

final class GameViewModel: NSObject, ObservableObject {
    @Published var isGameRunning = false
    @Published var timerValue = 0
    var audioPlayer: AVAudioPlayer?
    @Published var isMusicPlaying = false
    @Published var pauseGame = true
    func randomQuestion() -> QuizQuestion? {
        return QuizQuestion.quizData.randomElement()
    }
    func playEndingMusic() {
        guard let musicUrl = Bundle.main.url(forResource: "explousion", withExtension: "wav") else {
            print("Failed to find the ending music file.")
            return
        }
               
        do {
                audioPlayer = try AVAudioPlayer(contentsOf: musicUrl)
                audioPlayer?.delegate = self
                audioPlayer?.numberOfLoops = 1 // loop infinitely
                audioPlayer?.play()
                isMusicPlaying = true
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
            } else {
                self.audioPlayer?.stop()
                       self.isMusicPlaying = false
                
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
extension GameViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playBackgroundMusic()
    }
}
