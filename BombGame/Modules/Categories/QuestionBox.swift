//
//  QuestionBox.swift
//  BombGame
//
//  Created by Vitali Martsinovich on 2023-08-10.
//

import Foundation

struct QuestionWithCategory {
    var text: String
    var category: QuestionsBox.CategoryName
}

struct QuestionsBox {
    
//    var questionPool = [QuestionWithCategory]()
    
    var questionsAndCategories = [
        QuestionWithCategory(text: "miscellaneous", category: .miscellaneous),
        QuestionWithCategory(text: "aboutLifel", category: .aboutLife),
        QuestionWithCategory(text: "artsAndCinema", category: .artsAndCinema),
        QuestionWithCategory(text: "celebrities", category: .celebrities),
        QuestionWithCategory(text: "nature", category: .nature),
        QuestionWithCategory(text: "sportsAndHobbies", category: .sportsAndHobbies),
        QuestionWithCategory(text: "about all", category: .miscellaneous),
        QuestionWithCategory(text: "life is good", category: .aboutLife),
        QuestionWithCategory(text: "BARBY", category: .artsAndCinema),
        QuestionWithCategory(text: "JOHN SNOW", category: .celebrities),
        QuestionWithCategory(text: "Picture of nature", category: .nature),
        QuestionWithCategory(text: "Football", category: .sportsAndHobbies),
    ]
    
    enum CategoryName: String {
        case miscellaneous = "О Разном"
        case sportsAndHobbies = "Спорт и Хобби"
        case aboutLife = "Про Жизнь"
        case celebrities = "Знаменитости"
        case artsAndCinema = "Искусство и Кино"
        case nature = "Природа"
    }

    mutating func selectedCategory(categoryName: String) -> [QuestionWithCategory] {
        guard let category = CategoryName(rawValue: categoryName) else {
            // Handle the case when the category name is not recognized
            return []
        }

        let selectedQuestions = questionsAndCategories.filter { $0.category == category }
        return selectedQuestions
    }
}
