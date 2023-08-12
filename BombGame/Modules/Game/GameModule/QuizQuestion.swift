//
//  QuizQuestion.swift
//  BombGame
//
//  Created by Aleksey Kosov on 07.08.2023.
//

import Foundation

struct QuizQuestion: Codable {
    let category: QuestionsBox.CategoryName
    let question: String
  
    
    static func getRandomQuestion(categories: [QuestionsBox.CategoryName]) -> QuizQuestion {
        var questionArray: [QuizQuestion] = []
        for category in categories {
            switch category {
            case .aboutLife:
                questionArray.append(quizAboutLifeData.randomElement()!)
               
            case .miscellaneous:
                questionArray.append(quizAllData.randomElement()!)
            case .sportsAndHobbies:
                questionArray.append(quizSportsAndHobbiesData.randomElement()!)
            case .celebrities:
                questionArray.append(quizCelebretiesData.randomElement()!)
            case .artsAndCinema:
                questionArray.append(quizArtsandCinemaData.randomElement()!)
            case .nature:
                questionArray.append(quizNatureData.randomElement()!)
            }
        }
        return questionArray.randomElement()!
    }
    
    static let quizAllData: [QuizQuestion] = [
        QuizQuestion(category: .miscellaneous, question: "Назовите актеров Форсажа")
    ]
    static let quizAboutLifeData: [QuizQuestion] = [
        QuizQuestion(category: .aboutLife, question: "Сколько раз нужно посолить суп?"),
        QuizQuestion(category: .aboutLife, question: "Сколько нужно яиц для омлета?"),
        QuizQuestion(category: .aboutLife, question: "Назовите 5 ютуб-блогеров"),
    ]
    static let quizArtsandCinemaData: [QuizQuestion] = [
       
        QuizQuestion(category: .artsAndCinema, question: "Назовите фильмы Нолана"),
    ]
    
    
    static let quizCelebretiesData: [QuizQuestion] = [
        QuizQuestion(category: .celebrities, question: "Назовите актеров Форсажа")
    ]
    static let quizNatureData: [QuizQuestion] = [
        QuizQuestion(category: .nature, question: "Какие дерувья ростут в Африке"),
    ]
    

    static let quizSportsAndHobbiesData: [QuizQuestion] = [
       
        
        
        
        
        QuizQuestion(category: .sportsAndHobbies, question: "Какое ваше любимое спортивное мероприятие?"),
        QuizQuestion(category: .sportsAndHobbies, question: "Какие спортивные игры вы любите играть?"),
        QuizQuestion(category: .sportsAndHobbies, question: "Какой ваш любимый вид спорта для просмотра?"),
        QuizQuestion(category: .sportsAndHobbies, question: "Какую футбольную команду вы поддерживаете?"),
        QuizQuestion(category: .sportsAndHobbies, question: "Какими спортивными активностями вы увлекаетесь на выходных?"),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите 3 расстоновки игроков на футбольном поле"),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите вид спорта заканчивающийся на -бол "),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите вид спорта в котором играют ракетками"),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите 5 языков программирования"),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите 3 вида спорта где играют только руками "),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите 2 игрока получивших нарграду 'Золотой мяч'?"),
        QuizQuestion(category: .sportsAndHobbies, question: "Скажите как называется удар снизу вверх в боксе? "),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите 5 фруктов на английском языке"),
        QuizQuestion(category: .sportsAndHobbies, question: "Расскажите о себе на английском"),
        QuizQuestion(category: .sportsAndHobbies, question: "Вспомните названия 5 боевых искусств"),
        QuizQuestion(category: .sportsAndHobbies, question: "Вспомните неколько методов вызова перменной"),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите несколько произведений Эриха Фромма"),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите главных героев романа-эпопеи 'Война и мир' "),
        QuizQuestion(category: .sportsAndHobbies, question: "Назовите 3 струнных музыкальных инструмента")
    ]
}

