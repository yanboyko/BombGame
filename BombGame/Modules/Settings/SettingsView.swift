//
//  SettingsView.swift
//  BombGame
//
//  Created by Alexandr Rodionov on 8.08.23.
//

import SwiftUI

struct SettingsView: View {
    
    enum SelectedButton {
        case button1, button2, button3, button4
    }
    
    enum SelectedMusic: String, CaseIterable {
        case option1 = "Мелодия 1"
        case option2 = "Мелодия 2"
        case option3 = "Мелодия 3"
    }
    
    enum SelectedTickingBomb: String, CaseIterable {
        case option1 = "Часы 1"
        case option2 = "Часы 2"
        case option3 = "Часы 3"
    }
    
    enum SelectedExplosionBomb: String, CaseIterable {
        case option1 = "Взрыв 1"
        case option2 = "Взрыв 2"
        case option3 = "Взрыв 3"
    }

    @ObservedObject var gameview: GameViewModel
    @ObservedObject var viewModel: SettingsViewModel
    @EnvironmentObject var animationViewModel: AnimationViewModel
    
    @State private var selectedButton: SelectedButton = .button1
    
    @State private var playingWithTasks: Bool = true
    @State private var playibackgroundMusic: Bool = true
    @State private var animation: Bool = false
    
    @State var selectedMusic: SelectedMusic = .option1
    @State var selectedTickingBomb: SelectedTickingBomb = .option1
    @State var selectedExplosionBomb: SelectedExplosionBomb = .option1
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(spacing: 32) {
                
                VStack(spacing: 16) {
                    Text("Время игры")
                        .foregroundColor(Resources.Colors.mainPurple)
                        .font(.system(size: 30, weight: .heavy))
                    
                    
                    HStack(spacing: 16) {
                        TimeButton(isSelected: $selectedButton, textButton: "Короткое", buttonType: .button1) {
                            print("Действие для Кнопки 1")
                        }
                        TimeButton(isSelected: $selectedButton, textButton: "Среднее", buttonType: .button2) {
                            print("Действие для Кнопки 2")
                        }
                    }
                    
                    HStack(spacing: 16) {
                        TimeButton(isSelected: $selectedButton, textButton: "Длинное", buttonType: .button3) {
                            print("Действие для Кнопки 3")
                        }
                        TimeButton(isSelected: $selectedButton, textButton: "Случайное", buttonType: .button4) {
                            print("Действие для Кнопки 4")
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Text("Игра с заданиями")
                        .foregroundColor(Resources.Colors.mainPurple)
                        .font(.system(size: 26, weight: .heavy))
                    Spacer()
                    Toggle("", isOn: $playingWithTasks)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Resources.Colors.mainPurple))
                }
                HStack {
                    Text("Фоновая музыка")
                        .foregroundColor(Resources.Colors.mainPurple)
                        .font(.system(size: 26, weight: .heavy))
                    Spacer()
                    Toggle("", isOn: $playibackgroundMusic)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Resources.Colors.mainPurple))
                }
                
                HStack {
                    Text("Фоновая музыка")
                        .foregroundColor(Resources.Colors.mainPurple)
                        .font(.system(size: 26, weight: .heavy))
                    Spacer()
                    Menu(selectedMusic.rawValue) {
                        ForEach(SelectedMusic.allCases, id: \.self) { option in
                            Button(action: {
                                selectedMusic = option
                            }) {
                                Text(option.rawValue)
                            }
                        }
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                
                HStack {
                    Text("Тиканье бомбы")
                        .foregroundColor(Resources.Colors.mainPurple)
                        .font(.system(size: 26, weight: .heavy))
                    Spacer()
                    Menu(selectedTickingBomb.rawValue) {
                        ForEach(SelectedTickingBomb.allCases, id: \.self) { option in
                            Button(action: {
                                selectedTickingBomb = option
                            }) {
                                Text(option.rawValue)
                            }
                        }
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                
                HStack {
                    Text("Взрыв бомбы")
                        .foregroundColor(Resources.Colors.mainPurple)
                        .font(.system(size: 26, weight: .heavy))
                    Spacer()
                    Menu(selectedExplosionBomb.rawValue) {
                        ForEach(SelectedExplosionBomb.allCases, id: \.self) { option in
                            Button(action: {
                                selectedExplosionBomb = option
                            }) {
                                Text(option.rawValue)
                            }
                        }
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }
                
                HStack {
                    Text("Анимация")
                        .foregroundColor(Resources.Colors.mainPurple)
                        .font(.system(size: 26, weight: .heavy))
                    Spacer()
                    Toggle("", isOn: $animation)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Resources.Colors.mainPurple))
                }
                .onChange(of: animation) { newValue in
                    animationViewModel.turnAnimation()
                }
                Spacer()
                
            }
            .padding()
        }
    }
    
    struct TimeButton: View {
        
        @Binding var isSelected: SelectedButton
        var textButton: String
        var buttonType: SelectedButton
        var externalAction: () -> Void
        
        var body: some View {
            Button(action: {
                if isSelected == buttonType {
                    isSelected = .button1
                } else {
                    isSelected = buttonType
                }
                externalAction()
            }) {
                Text(textButton)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(isSelected == buttonType ? Resources.Colors.mainText : Resources.Colors.mainPurple)
                    .font(.system(size: 26, weight: .bold))
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isSelected == buttonType ? Resources.Colors.mainPurple : Resources.Colors.mainText)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .shadow(color: .black, radius: 5, x: 5, y: 5)
            }
        }
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(gameview: GameViewModel(), viewModel: SettingsViewModel())
    }
}
