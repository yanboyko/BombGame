import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State var firstTouchButton = false
    @State var buttonName = "Запустить"
    @State var pauseGameView = false
    @State var stopName = "Пауза"
    var body: some View {
//        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    HStack(alignment: .center) {
                        Button {
                           //
                        } label: {
                            Image(systemName: Resources.Image.back)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text("\(viewModel.timerValue)")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Resources.Colors.mainPurple)
                            .padding(.bottom)
                        Spacer()
                        Button {
                            viewModel.tpauseGame()
                           
                        } label: {
                            if viewModel.pauseGame {Image(systemName:"pause.circle") }else{ Image(systemName:"play.circle")
                                
                            }
                        }.font(.largeTitle)
                            .foregroundColor(.black)
                            
                    }
                    .padding()
                    
                    Text("Нажмите")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Resources.Colors.mainPurple)
                    Text("\"Запустить\" чтобы начать игру")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Resources.Colors.mainPurple)
                    Image(Resources.Image.bomb)
                        .padding(.leading)
                    
                    Spacer()
                    
                    ActionButton(text: (viewModel.pauseGame ? $stopName : $buttonName) ) {
                        
                        viewModel.tpauseGame()

                        if firstTouchButton{
                            viewModel.startGame()
                            
                        }else{
                            viewModel.playBackgroundMusic()
                        }
                        firstTouchButton = true
                                            
                    }
                }
            }
//        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
