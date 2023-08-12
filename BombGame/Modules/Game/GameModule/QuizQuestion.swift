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
  
    static func getRandomQuestion(category: QuestionsBox.CategoryName) -> QuizQuestion {
        QuizQuestion.quizData.randomElement() ?? QuizQuestion(category: .aboutLife, question: "Не удалось сгенерировать вопрос")
    }
  
    static let quizData: [QuizQuestion] = [
        QuizQuestion(category: .aboutLife, question: "Сколько раз нужно посолить суп?"),
        QuizQuestion(category: .aboutLife, question: "Сколько нужно яиц для омлета?"),
        QuizQuestion(category: .aboutLife, question: "Назовите 5 ютуб-блогеров"),
        
        QuizQuestion(category: .celebrities, question: "Назовите актеров Форсажа"),
        QuizQuestion(category: .artsAndCinema, question: "Назовите фильмы Нолана"),
        QuizQuestion(category: .nature, question: "Какие дерувья ростут в Африке"),
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
