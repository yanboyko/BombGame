//
//  Punishment.swift
//  BombGame
//
//  Created by Aleksey Kosov on 07.08.2023.
//

import Foundation

enum Punishment: CaseIterable {
    case clapHandsAfterAnswer
    case clapHandsBeforeAnswer
    case whistleGoodbye
    case swapHands
    case singSong
    case funnyAccent
    case rhymeAnswers
    case threeLetterNames
    case jokeBeforeAnswer
    case famousCharacterImpersonation
    case leftHandPass
    case pantomimeAnswers

    var text: String {
        switch self {
        case .clapHandsAfterAnswer:
            return "В следующем раунде после каждого ответа хлопать в ладоши"
        case .clapHandsBeforeAnswer:
            return "Перед каждым ответом хлопать в ладоши."
        case .whistleGoodbye:
            return "Свистеть 'До свидания' перед каждым ответом в следующем раунде."
        case .swapHands:
            return "Постоянно менять местами левую и правую руку передачи 'бомбы'."
        case .singSong:
            return "Напевать песню в произвольном месте ответа."
        case .funnyAccent:
            return "Отвечать, используя смешный акцент или голос."
        case .rhymeAnswers:
            return "Отвечать на вопросы только в форме стихотворения или рифмы."
        case .threeLetterNames:
            return "Отвечать, используя только трибуквенные имена в следующем раунде."
        case .jokeBeforeAnswer:
            return "Придумайте шутку перед каждым ответом."
        case .famousCharacterImpersonation:
            return "Отвечать, представляя себя знаменитым персонажем."
        case .leftHandPass:
            return "Передавать 'бомбу' следующему игроку, используя только левую руку."
        case .pantomimeAnswers:
            return "Отвечать на вопросы, используя только пантомиму без слов."
        }
    }

    // Функция для получения случайного наказания из перечисления
    static func getRandomPunishment() -> Punishment {
        let allPunishments = Punishment.allCases
        let randomIndex = Int.random(in: 0..<allPunishments.count)
        return allPunishments[randomIndex]
    }
}

