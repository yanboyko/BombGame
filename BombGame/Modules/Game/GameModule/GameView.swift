import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    @State var buttonName = "Запустить"
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    HStack(alignment: .center) {
                        Button {
                            viewModel.goBack()
                        } label: {
                            Image(systemName: Resources.Image.back)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text("ИГРА")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Resources.Colors.mainPurple)
                            .padding(.bottom)
                        Spacer()
                        Button {
                            viewModel.setOnPause()
                        } label: {
                            Image(Resources.Image.pause)
                        }
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
                    
                    ActionButton(text: $buttonName) {
                        viewModel.startGame()
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
