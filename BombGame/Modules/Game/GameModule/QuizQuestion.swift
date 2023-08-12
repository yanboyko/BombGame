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
    
    static let quizAllData: [QuizQuestion] =  quizAboutLifeData + quizArtsandCinemaData + quizCelebretiesData + quizNatureData + quizSportsAndHobbiesData
    static let quizAboutLifeData: [QuizQuestion] = [
        QuizQuestion(category: .aboutLife, question: "Сколько раз нужно посолить суп?"),
        QuizQuestion(category: .aboutLife, question: "Сколько нужно яиц для омлета?"),
        QuizQuestion(category: .aboutLife, question: "Назовите 5 ютуб-блогеров"),
        QuizQuestion(category: .aboutLife, question: "Расскажите о 2-ух знаменитостях"),
        QuizQuestion(category: .aboutLife, question: "Назовите 3 самых популярных (на ваш взгляд) блюда в России")
    ]
    static let quizArtsandCinemaData: [QuizQuestion] = [
        
        QuizQuestion(category: .artsAndCinema, question: "Назовите фильмы Нолана"),
        QuizQuestion(category: .artsAndCinema, question: "Назовите 3 фильма в которых снимлся актер Джони Дэп"),
        QuizQuestion(category: .artsAndCinema, question: "Назвоите 5 мстителей"),
        QuizQuestion(category: .artsAndCinema, question: "Назовите 3 актеров получивших Оскар"),
        QuizQuestion(category: .artsAndCinema, question: "Назовите 4 фильма жанра боевик"),
        QuizQuestion(category: .artsAndCinema, question: "Назовите 2 самых кассовых фильма в мире"),
        QuizQuestion(category: .artsAndCinema, question: "Назвоите 2 фильма про российские 90-е "),
   
        
    ]
    
    
    static let quizCelebretiesData: [QuizQuestion] = [
        QuizQuestion(category: .celebrities, question: "Назовите актеров Форсажа"),
        QuizQuestion(category: .celebrities, question: "Назовите 2 актера из фильма 'Пираты Карибского моря'"),
        QuizQuestion(category: .celebrities, question: "Назвоите 3 самых известных актеров мира"),
        QuizQuestion(category: .celebrities, question: "Назовите 2 фильма от Тарантино"),
        QuizQuestion(category: .celebrities, question: "Назовите актеров из серила 'FRIENDS'")
        
    ]
    static let quizNatureData: [QuizQuestion] = [
        QuizQuestion(category: .nature, question: "Какие дерувья растут в Африке"),
        QuizQuestion(category: .nature, question: "Назовите хим состав углекислого газа"),
        QuizQuestion(category: .nature, question: "Назовите 5 насекомых"),
        QuizQuestion(category: .nature, question: "Расскажиет о круговороте воды в природе"),
        QuizQuestion(category: .nature, question: "Назовите 3 автора книг про природу")
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

