import SwiftUI
import RiveRuntime

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var animationViewModel: AnimationViewModel
    @ObservedObject var gameViewModel: GameViewModel
    
    @State private var startGame = Resources.Text.startGame
    @State private var proceedGame = Resources.Text.proceedGame
    @State private var categories = Resources.Text.categories
    
    @State private var showCategoriesScreen = false
    @State private var showGameScreen = false
    @State private var showHelpScreen = false
    @State private var showSettingsScreen = false
    
    var startGameButton = RiveViewModel(fileName: "startgamebutton", extension: "riv", stateMachineName: "StateMachine", autoPlay: false, artboardName: "MainButton")
    var resumeGameButton = RiveViewModel(fileName: "resumebutton", extension: "riv", stateMachineName: "StateMachine", autoPlay: false, artboardName: "MainButton")
    var categoriesButton = RiveViewModel(fileName: "categoriesbutton", extension: "riv", stateMachineName: "StateMachine", autoPlay: false, artboardName: "MainButton")
    var settingsbutton = RiveViewModel(fileName: "settingsbutton", extension: "riv", stateMachineName: "StateMachine", autoPlay: false, artboardName: "MainButton")
    var helpbutton = RiveViewModel(fileName: "helpbutton", extension: "riv", stateMachineName: "StateMachine", autoPlay: false, artboardName: "MainButton")
    var bombanimation = RiveViewModel(fileName: "bombanimation", extension: "riv", stateMachineName: "StateMachine", autoPlay: false, artboardName: "BombArtboard")
    var bombLabel = RiveViewModel(fileName: "bomblabel1", extension: "riv", stateMachineName: "StateMachine", autoPlay: false, artboardName: "MainArtboard")
    
    @State private var startGameButtonIsPressed = false
    @State private var resumeGameButtonIsPressed = false
    @State private var categoriesButtonIsPressed = false
    @State private var settingsbuttonIsPressed = false
    @State private var helpbuttonIsPressed = false
    @State private var bombLabelIsPressed = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    BackgroundView()
                    VStack {
                        
                        if !animationViewModel.addAnimation {
                            VStack {
                                Text(Resources.Text.mainScreenTitle)
                                    .font(.system(size: 32, weight: .heavy))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                Text(Resources.Text.bomb)
                                    .font(.system(size: 48, weight: .heavy))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Resources.Colors.mainPurple)
                                Image(Resources.Image.bombForMain)
                                    .resizable()
                                    .scaledToFit()
                            }
                        } else {
                            VStack {
                                bombLabel.view()
                            }
                            .frame(height: geometry.size.height / 10)
                            .padding(.top)
                            .shadow(color: .gray, radius: 5, x: 5, y: 5)
                            .scaleEffect(bombLabelIsPressed ? 1.05 : 1.0)
                            .pressEvents {
                                bombLabel.reset()
                                bombLabel.setInput("timeline", value: 1.0)
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    bombLabelIsPressed = true
                                }
                            } onRelease: {
                                bombLabel.setInput("timeline", value: 2.0)
                                withAnimation {
                                    bombLabelIsPressed = false
                                }
                            }
                            
                            VStack {
                                bombanimation.view()
                            }
                            .padding(.leading, 64)
                            .onAppear {
                                bombanimation.setInput("timeline", value: 1.0)
                            }
                        }
                        
                        if !animationViewModel.addAnimation {
                            VStack {
                                ActionButton(text: $startGame, onTapAction: {
                                    showGameScreen = true
                                    
                                        gameViewModel.isMusicPlayingw = false
                                    
                                   
                                    
                                })
                                
                                ActionButton(text: $proceedGame, onTapAction: {
                                showGameScreen = true
                                    
                                })
                                .disabled(gameViewModel.contBut)
                                .opacity(gameViewModel.contBut ? 0.5 : 1 )
                                             
                                ActionButton(text: $categories, onTapAction: {
                                    showCategoriesScreen = true }
                                )
                            }
                            .frame(height: geometry.size.height / 3)
                        } else {
                            VStack(spacing: 16) {
                                startGameButton.view()
                                    .shadow(color: .black, radius: 5, x: 5, y: 10)
                                    .scaleEffect(startGameButtonIsPressed ? 1.05 : 1.0)
                                    .pressEvents {
                                        startGameButton.setInput("timeline", value: 1.0)
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            startGameButtonIsPressed = true
                                        }
                                    } onRelease: {
                                        startGameButton.setInput("timeline", value: 2.0)
                                        withAnimation {
                                            startGameButtonIsPressed = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            showGameScreen = true
                                        }
                                    }
                                
                                resumeGameButton.view()
                                    .shadow(color: .black, radius: 5, x: 5, y: 10)
                                    .scaleEffect(resumeGameButtonIsPressed ? 1.05 : 1.0)
                                    .pressEvents {
                                        resumeGameButton.setInput("timeline", value: 1.0)
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            resumeGameButtonIsPressed = true
                                        }
                                    } onRelease: {
                                        resumeGameButton.setInput("timeline", value: 2.0)
                                        withAnimation {
                                            resumeGameButtonIsPressed = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            // Условия для кнопки продолжить
                                            showGameScreen = true
                                        }
                                    }
                                
                                categoriesButton.view()
                                    .shadow(color: .black, radius: 5, x: 5, y: 10)
                                    .scaleEffect(categoriesButtonIsPressed ? 1.05 : 1.0)
                                    .pressEvents {
                                        categoriesButton.setInput("timeline", value: 1.0)
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            categoriesButtonIsPressed = true
                                        }
                                    } onRelease: {
                                        categoriesButton.setInput("timeline", value: 2.0)
                                        withAnimation {
                                            categoriesButtonIsPressed = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            showCategoriesScreen = true
                                        }
                                    }
                            }
                            .frame(height: geometry.size.height / 3)
                        }
                        
                        if !animationViewModel.addAnimation {
                            HStack {
                                CircleButton(imageName: Resources.Image.settings, onTapAction: {
                                    showSettingsScreen = true
                                })
                                Spacer()
                                CircleButton(imageName: Resources.Image.helpImage, onTapAction: {
                                    showHelpScreen = true
                                })
                            }
                            .frame(height: geometry.size.height / 10)
                            .padding(.horizontal)
                        } else {
                            HStack {
                                settingsbutton.view()
                                    .frame(width: 100)
                                    .shadow(color: .black, radius: 5, x: 5, y: 10)
                                    .scaleEffect(settingsbuttonIsPressed ? 1.05 : 1.0)
                                    .pressEvents {
                                        settingsbutton.setInput("timeline", value: 1.0)
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            settingsbuttonIsPressed = true
                                        }
                                    } onRelease: {
                                        settingsbutton.setInput("timeline", value: 2.0)
                                        withAnimation {
                                            settingsbuttonIsPressed = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            showSettingsScreen = true
                                        }
                                    }
                                
                                Spacer()
                                helpbutton.view()
                                    .frame(width: 100)
                                    .shadow(color: .black, radius: 5, x: 5, y: 10)
                                    .scaleEffect(helpbuttonIsPressed ? 1.05 : 1.0)
                                    .pressEvents {
                                        helpbutton.setInput("timeline", value: 1.0)
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            helpbuttonIsPressed = true
                                        }
                                    } onRelease: {
                                        helpbutton.setInput("timeline", value: 2.0)
                                        withAnimation {
                                            helpbuttonIsPressed = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            showHelpScreen = true
                                        }
                                    }
                            }
                            .frame(height: geometry.size.height / 15)
                        }
                    }
                }
            }
            .background(
                NavigationLink(
                    destination: CategoriesView(viewModel: CategoriesViewModel()),
                    isActive: $showCategoriesScreen,
                    label: { EmptyView() }
                ))
            .background(
                NavigationLink(
                    destination: GameView(viewModel: GameViewModel()),
                    isActive: $showGameScreen,
                    label: { EmptyView() }
                ))
            .background(
                NavigationLink(
                    destination: AssistanceView(viewModel: AssistanceViewModel()),
                    isActive: $showHelpScreen,
                    label: { EmptyView() }
                ))
            .background(
                NavigationLink(
                    destination: SettingsView(gameview: GameViewModel(), viewModel: SettingsViewModel()),
                    isActive: $showSettingsScreen,
                    label: { EmptyView() }
                ))
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(), gameViewModel: GameViewModel())
            .environmentObject(AnimationViewModel())
            
    }
}
