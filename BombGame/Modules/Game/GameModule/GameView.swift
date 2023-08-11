import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
  
    @State var startButtonName = Resources.Text.startButtonName
    @State var stopButtonName = Resources.Text.stopButtonName
    @State var pauseGameView = false
    @State var startStopButtonVisible = true
    @State var showGameScreen = false
   // @State private var currentQuestion: QuizQuestion?
    
    @Environment(\.presentationMode) var presentationMode
    
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
                                if viewModel.isGamePaused {
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
                        Text("Нажмите")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Resources.Colors.mainPurple)
                        Text("\"Запустить\" чтобы начать игру")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Resources.Colors.mainPurple)
                    } else {
                        if viewModel.isGamePaused {
                            Text(viewModel.currentGame?.currentQuestion.question ?? "")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Resources.Colors.mainPurple)
                                .padding(.horizontal)
                        } else {
                            Text(stopButtonName)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Resources.Colors.mainPurple)
                        }
                    }
                    
                    Image(Resources.Image.bomb)
                        .padding(.leading)
                    
                    Spacer()
                    
                    if startStopButtonVisible {
                        ActionButton(text: $startButtonName) {
                            viewModel.timerValue = 20
                            viewModel.playBackgroundMusic()
                            startStopButtonVisible = false
                            viewModel.startGame()
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
//        GameView(viewModel: GameViewModel())
//    }
//}
