    

import Foundation
import AVFoundation
final class GameViewModel: ObservableObject {
    @Published var isGameRunning = false
    @Published var timerValue = 20
    var audioPlayer: AVAudioPlayer?
    @Published var isMusicPlaying = false
    @Published var pauseGame = false
    
    func onPauseGame(){
        if pauseGame{
            self.audioPlayer = nil
            self.isMusicPlaying = false
            
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
    
    //------------------Таймер---------
    private var timer: Timer? // Таймер для обратного отсчета
    
    func startGame() {
        guard !isGameRunning else { return }
        
        isGameRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timerValue > 0 {
                self.timerValue -= 1
                self.audioPlayer?.play()
                self.isMusicPlaying = true
            } else {
                
                self.audioPlayer = nil
                self.isMusicPlaying = false
            }
        }
    }
    
  
}
//-------------------------------------
