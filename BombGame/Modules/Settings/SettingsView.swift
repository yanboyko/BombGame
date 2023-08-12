import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @EnvironmentObject var animationViewModel: AnimationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var oldAnimation = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    HStack {
                        Text("Время игры")
                            .foregroundColor(Resources.Colors.mainPurple)
                            .font(.system(size: 30, weight: .heavy))
                        Spacer()
                    }
                    TimeButtonsView(selectedTimeButton: $viewModel.selectedTimeButton)
                }
                ToggleStack(
                    isOn: $viewModel.isTask,
                    text: "Игра с заданиями",
                    onToggleAction: { viewModel.isTask.toggle() }
                )
                ToggleStack(
                    isOn: $viewModel.isBackgroundMusic,
                    text: "Фоновая музыка",
                    onToggleAction: { viewModel.isBackgroundMusic.toggle() }
                )
                TextStack(
                    text: "Фоновая музыка",
                    stackOption: .selectedMusic,
                    selectedMusic: $viewModel.selectedMusic,
                    selectedTickingBomb: $viewModel.selectedTickingBomb,
                    selectedExplosionBomb: $viewModel.selectedExplosionBomb
                )
                TextStack(
                    text: "Тиканье бомбы",
                    stackOption: .selectedTickingBomb,
                    selectedMusic: $viewModel.selectedMusic,
                    selectedTickingBomb: $viewModel.selectedTickingBomb,
                    selectedExplosionBomb: $viewModel.selectedExplosionBomb
                )
                TextStack(
                    text: "Взрыв бомбы",
                    stackOption: .selectedExplosionBomb,
                    selectedMusic: $viewModel.selectedMusic,
                    selectedTickingBomb: $viewModel.selectedTickingBomb,
                    selectedExplosionBomb: $viewModel.selectedExplosionBomb
                )
//                ToggleStack(
//                    isOn: $viewModel.isAnimation,
//                    text: "Анимация",
//                    onToggleAction: {
//                        viewModel.isAnimation.toggle()
//                        animationViewModel.turnAnimation()
//                    }
//                )
                
                HStack {
                    Text("Анимация")
                        .foregroundColor(Resources.Colors.mainPurple)
                        .font(.system(size: 20, weight: .heavy))
                    Spacer()
                    Toggle("", isOn: $oldAnimation)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Resources.Colors.mainPurple))
                        .onChange(of: oldAnimation) { newValue in
                            viewModel.isAnimation.toggle()
                            animationViewModel.turnAnimation()
                        }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Настройки").font(.title).bold()
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                }
            }
        }
        .foregroundColor(Resources.Colors.mainPurple)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.async {
                viewModel.loadSettings()
            }
        }
        .onDisappear {
            viewModel.saveSettings()
        }
    }
}

private struct TimeButtonsView: View {
    @Binding var selectedTimeButton: TimeButtonType
    
    var body: some View {
        HStack(spacing: 16) {
            TimeButton(
                text: "Короткое",
                buttonType: .short,
                isSelected: selectedTimeButton == .short ? true : false
            ) {
                selectedTimeButton = .short
                print("Действие для Кнопки 1")
            }
            TimeButton(
                text: "Среднее",
                buttonType: .average,
                isSelected: selectedTimeButton == .average ? true : false
            ) {
                selectedTimeButton = .average
                print("Действие для Кнопки 2")
            }
        }
        
        HStack(spacing: 16) {
            TimeButton(
                text: "Длинное",
                buttonType: .long,
                isSelected: selectedTimeButton == .long ? true : false
            ) {
                selectedTimeButton = .long
                print("Действие для Кнопки 3")
            }
            TimeButton(
                text: "Случайное",
                buttonType: .random,
                isSelected: selectedTimeButton == .random ? true : false
            ) {
                selectedTimeButton = .random
                print("Действие для Кнопки 4")
            }
        }
    }
}

private struct TimeButton: View {
    let text: String
    let buttonType: TimeButtonType
    var isSelected: Bool
    let onTapAction: () -> ()
    
    var body: some View {
        if isSelected {
            Button {
                onTapAction()
            } label: {
                Text(text)
                    .font(.system(size: 16, weight: .heavy))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("mainTextColor"))
            }
            .frame(width: 147, height: 38)
            .background(Color("mainPurple"))
            .cornerRadius(50)
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 2)
            .shadow(color: .black.opacity(0.08), radius: 1, x: 0, y: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.black, lineWidth: 1)
            )
        } else {
            Button {
                onTapAction()
            } label: {
                Text(text)
                    .font(.system(size: 16, weight: .heavy))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("mainPurple"))
            }
            .frame(width: 147, height: 38)
            .background(Color("mainTextColor"))
            .cornerRadius(50)
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 2)
            .shadow(color: .black.opacity(0.08), radius: 1, x: 0, y: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.black, lineWidth: 1)
            )
        }
        
        
    }
}

private struct ToggleStack: View {
    @Binding var isOn: Bool
    let text: String
    let onToggleAction: () -> Void
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(Resources.Colors.mainPurple)
                .font(.system(size: 20, weight: .heavy))
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: Resources.Colors.mainPurple))
                .onChange(of: isOn) { newValue in
                    onToggleAction()
                }
        }
    }
}

private struct TextStack: View {
    let text: String
    let stackOption: TextStackOptions
    
    @Binding var selectedMusic: MusicType
    @Binding var selectedTickingBomb: TickingBombMusicType
    @Binding var selectedExplosionBomb: ExplosionBombMusicType
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(Resources.Colors.mainPurple)
                .font(.system(size: 20, weight: .heavy))
            Spacer()
            switch stackOption {
            case .selectedMusic:
                Menu(selectedMusic.rawValue) {
                    ForEach(MusicType.allCases, id: \.self) { option in
                        Button(action: {
                            selectedMusic = option
                        }) {
                            Text(option.rawValue)
                        }
                    }
                }
                .foregroundColor(.black)
                .font(.headline)
            case .selectedTickingBomb:
                Menu(selectedTickingBomb.rawValue) {
                    ForEach(TickingBombMusicType.allCases, id: \.self) { option in
                        Button(action: {
                            selectedTickingBomb = option
                        }) {
                            Text(option.rawValue)
                        }
                    }
                }
                .foregroundColor(.black)
                .font(.headline)
            case .selectedExplosionBomb:
                Menu(selectedExplosionBomb.rawValue) {
                    ForEach(ExplosionBombMusicType.allCases, id: \.self) { option in
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
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel())
    }
}
