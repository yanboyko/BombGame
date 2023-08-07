//
//  QuizQuestion.swift
//  BombGame
//
//  Created by Aleksey Kosov on 07.08.2023.
//

import Foundation

struct QuizQuestion {
    let question: String
    let answer: String

    static let quizData: [QuizQuestion] = [
        QuizQuestion(question: "Назовите безалкогольный напиток", answer: "Вода"),
        QuizQuestion(question: "Назовите 3 вида спорта", answer: "Футбол, баскетбол, теннис"),
        QuizQuestion(question: "Назовите компанию, которая имеет логотип в виде яблока", answer: "Apple"),
        QuizQuestion(question: "Назовите какой цвет получится при смешивании желтого и зеленого", answer: "Зеленый"),
        QuizQuestion(question: "Назовите вторую по счету планету в солнечной системе", answer: "Венера"),
        QuizQuestion(question: "Сколько ног у муравья", answer: "6"),
        QuizQuestion(question: "Какое животное издает 'мяу'", answer: "Кошка"),
        QuizQuestion(question: "Какая буква является первой в алфавите", answer: "A"),
        QuizQuestion(question: "Сколько дней в феврале в високосном году", answer: "29"),
        QuizQuestion(question: "Как называется столица Испании", answer: "Мадрид"),
        QuizQuestion(question: "Как зовут принцессу-героиню в сказке 'Спящая красавица'", answer: "Аврора"),
        QuizQuestion(question: "Какой цвет получается при смешивании синего и желтого", answer: "Зеленый"),
        QuizQuestion(question: "Какое животное является символом Великобритании", answer: "Лев"),
        QuizQuestion(question: "Сколько пальцев на руке у человека", answer: "5"),
        QuizQuestion(question: "Какую форму имеет футбольное поле", answer: "Прямоугольник"),
        QuizQuestion(question: "Как называется первый месяц календарного года", answer: "Январь"),
        QuizQuestion(question: "Сколько кварталов в году", answer: "4"),
        QuizQuestion(question: "Сколько дней в августе", answer: "31"),
        QuizQuestion(question: "Кто является президентом Соединенных Штатов Америки", answer: "Joe Biden"),
        QuizQuestion(question: "Какое имя у главного героя сказки 'Красная Шапочка'", answer: "Шапка"),
    ]
}


