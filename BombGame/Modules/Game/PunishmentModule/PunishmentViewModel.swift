//
//  PunishmentViewModel.swift
//  BombGame
//
//  Created by Aleksey Kosov on 07.08.2023.
//

import Foundation

@MainActor final class PunishmentViewModel: ObservableObject {
    @Published var punishment: Punishment
    @Published var isPunishmentNeeded: Bool = false
    var settings: SettingsModel? = nil
    let defaults = UserDefaults.standard
    
    init() {
        self.punishment = Punishment.clapHandsAfterAnswer
        
        loadSettings()
    }

    func getAnotherQuestion() {
        self.punishment = Punishment.getRandomPunishment()
    }

    func restartGame() {
        
    }

    func setOnPause() {

    }
    
    private func loadSettings()  {
        if let savedData = defaults.data(forKey: "settings") {
            if let settings = try? JSONDecoder().decode(SettingsModel.self, from: savedData) {
                self.settings = settings
            }
        } else {
            self.settings = SettingsModel(
                time: .short,
                isTask: true,
                isBackgroundMusic: true,
                backgroundMusicType: .melodyOne,
                tickingBomb: .tickOne,
                explosionBomb: .explosionOne,
                isAnimation: false
            )
        }
        
        isPunishmentNeeded = settings!.isTask
    }
}
