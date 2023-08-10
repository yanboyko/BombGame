//
//  Resources.swift
//  BombGame
//
//  Created by Vitali Martsinovich on 2023-08-07.
//

import Foundation
import SwiftUI

enum Resources {
    
    enum Colors {
        static let mainText = Color("mainTextColor")
        static let mainPurple = Color("mainPurple")
    }
    
    enum Image {
        static let categoryOne = "category1"
        static let categoryTwo = "category2"
        static let categoryThree = "category3"
        static let categoryFour = "category4"
        static let categoryFive = "category5"
        static let categorySix = "category6"
        static let bomb = "bomb"
        static let bombForMain = "bombForMain"
        static let settings = "settings"
        static let helpImage = "rules"
        static let circle = "circle"

        static let punishment = "punishment"
        static let pause = "pause.circle"
        static let play = "play.cicrle"
        static let back = "chevron.left"
        
    }
    
    enum Text {
        static let bomb = "БОМБА"
        static let mainScreenTitle = "Игра для компании"
        static let startGame = "Старт игры"
        static let proceedGame = "Продолжить"
        static let categories = "Категории"
        static let startButtonName = "Запустить"
        static let stopButtonName = "Пауза"
    }
    
    enum Fonts {
    }
}
