import SwiftUI
import RiveRuntime

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var animationViewModel: AnimationViewModel
    
    @State private var startGame = "Старт игры"
    @State private var proceedGame = "Продолжить"
    @State private var categories = "Категории"
    
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
    
    @State private var startGameButtonIsPressed = false
    @State private var resumeGameButtonIsPressed = false
    @State private var categoriesButtonIsPressed = false
    @State private var settingsbuttonIsPressed = false
    @State private var helpbuttonIsPressed = false
    
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
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 300)
                            }
                            .padding(.vertical)
                        } else {
                            VStack {
                                bombanimation.view()
                            }
                            .onAppear {
                                bombanimation.setInput("timeline", value: 1.0)
                                print("geometry", geometry.size)
                            }
                        }

                        if !animationViewModel.addAnimation {
                            VStack {
                                ActionButton(text: $startGame, onTapAction: {
                                    showGameScreen = true
                                })
                                ActionButton(text: $proceedGame, onTapAction: viewModel.proceedGamePressed)
                                ActionButton(text: $categories, onTapAction: {
                                    showCategoriesScreen = true }
                                )
                            }
                        } else {
                            VStack {
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
                        } else {
                            HStack {
                                settingsbutton.view()
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
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                            showSettingsScreen = true
                                        }
                                    }
                                Spacer()
                                helpbutton.view()
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
                                    }
                            }
                            .frame(height: geometry.size.height / 10)
                        }
                    }
                  //  .padding(.horizontal)
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
                    destination: SettingsView(viewModel: SettingsViewModel()),
                    isActive: $showSettingsScreen,
                    label: { EmptyView() }
                ))
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
            .environmentObject(AnimationViewModel())
    }
}
