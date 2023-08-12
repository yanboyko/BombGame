import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
  
    @State var startButtonName = Resources.Text.startButtonName
    @State var stopButtonName = Resources.Text.stopButtonName
    @State var startStopButtonVisible = true
    @State var showGameScreen = false

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
                        Text("Нажмите")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Resources.Colors.mainPurple)
                        Text("\"Запустить\" чтобы начать игру")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Resources.Colors.mainPurple)
                    } else {
                        if !viewModel.isGameOnPause {
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
//                            viewModel.timerValue = 20
//                            viewModel.playBackgroundMusic()
//                            startStopButtonVisible = false
//                            viewModel.startGame()
                            viewModel.initilizeGame()
                          //  viewModel.startGame()
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
//        GameView(viewModel: GameViewModel())
//    }
//}
