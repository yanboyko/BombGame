import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State var isButtonVisible = true
    @State var buttonName = "Запустить"
    @State var pauseGameView = false
    @State var stopName = "Пауза"
    @State private var currentQuestion: QuizQuestion?
    var body: some View {
        //        NavigationView {
        ZStack {
            
            
            
            BackgroundView()
            
            if viewModel.timerEnded{
                PunishmentView(viewModel: PunishmentViewModel())
            }else{
                
                
                VStack {
                    HStack(alignment: .center) {
                        Button {
                            //
                        } label: {
                            Image(systemName: Resources.Image.back)
                                .foregroundColor(.black)
                        }
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
                    if isButtonVisible{
                        Text("Нажмите")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Resources.Colors.mainPurple)
                        Text("\"Запустить\" чтобы начать игру")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Resources.Colors.mainPurple)
                    }else{
                        if viewModel.pauseGame{
                            Text(currentQuestion?.question ?? "")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Resources.Colors.mainPurple)
                            
                        }else{
                            Text(stopName)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Resources.Colors.mainPurple)
                            
                        }
                    }
                    Image(Resources.Image.bomb)
                        .padding(.leading)
                    
                    Spacer()
                    if isButtonVisible{
                        ActionButton(text: $buttonName ) {
                            viewModel.timerValue = 20
                            viewModel.playBackgroundMusic()
                            currentQuestion = viewModel.randomQuestion()
                            isButtonVisible = false
                            
                            viewModel.startGame()
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
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
