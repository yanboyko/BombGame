//
//  PunishmentViewModel.swift
//  BombGame
//
//  Created by Aleksey Kosov on 07.08.2023.
//

import Foundation

@MainActor final class PunishmentViewModel: ObservableObject {

    @Published var punishment: Punishment

    func getAnotherQuestion() {
        self.punishment = Punishment.getRandomPunishment()
    }

    func restartGame() {
        
    }

    func goBack() {

    }

    func setOnPause() {

    }

    init() {
        self.punishment = Punishment.getRandomPunishment()
    }
}
