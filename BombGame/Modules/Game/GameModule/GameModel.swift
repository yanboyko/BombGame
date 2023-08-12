//
//  GameModel.swift
//  BombGame
//
//  Created by Aleksey Kosov on 11.08.2023.
//

import Foundation

struct GameModel: Codable {
    var currentQuestion: QuizQuestion
    var timeLeft: Int
}
