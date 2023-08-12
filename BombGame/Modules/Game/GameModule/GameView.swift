import SwiftUI
import RiveRuntime

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State var startTitle = Resources.Text.startButtonName
    @State var stopTitle = Resources.Text.stopButtonName
    @State var startStopButtonVisible = true
    @State var showGameScreen = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var animationViewModel: AnimationViewModel
    
    var bombanimation = RiveViewModel(
        fileName: "bombanimation",
        extension: "riv",
        stateMachineName: "StateMachine",
        autoPlay: false,
        artboardName: "BombArtboard"
    )
    
    var body: some View {
        ZStack {
            BackgroundView()
            if viewModel.timerEnded {
                PunishmentView(viewModel: PunishmentViewModel()) {
                    viewModel.isFreshGame = true
                    viewModel.updateGame()
                }
            } else {
                VStack {
                    HStack(alignment: .center) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            viewModel.stopGame()
                        } label: {
                            Image(systemName: Resources.Image.back)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        if !startStopButtonVisible {
                            Button {
                                viewModel.pauseGame()
                            } label: {
                                if !viewModel.isGameOnPause {
                                    Image(systemName:"pause.circle")
                                } else {
                                    Image(systemName:"play.circle")
                                }
                            }
                            .font(.largeTitle)
                            .foregroundColor(.black)
                        }
                    }
                    .padding()
                    if startStopButtonVisible {
                        Text("Нажмите \n \"Запустить\" чтобы начать игру")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Resources.Colors.mainPurple)
                            .multilineTextAlignment(.center)
                    } else {
                        if !viewModel.isGameOnPause {
                            Text(viewModel.currentGame?.currentQuestion.question ?? "")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Resources.Colors.mainPurple)
                                .padding(.horizontal)
                        } else {
                            Text(stopTitle)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Resources.Colors.mainPurple)
                        }
                    }
                    
                    if !animationViewModel.addAnimation {
                        Image(Resources.Image.bomb)
                            .padding(.leading)
                    } else {
                        VStack {
                            bombanimation.view()
                        }
                        .padding(.leading, 64)
                        .onAppear {
                            bombanimation.setInput("timeline", value: 1.0)
                        }
                    }

                    Spacer()
                    if startStopButtonVisible {
                        ActionButton(text: $startTitle) {
                            viewModel.initilizeGame()
                            startStopButtonVisible = false
                        }
                    }
                }
            }
        }
        .onDisappear {
            viewModel.gameViewDissapear()
        }
        .navigationBarHidden(true)
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(viewModel: GameViewModel(isFreshGame: true))
//    }
//}
