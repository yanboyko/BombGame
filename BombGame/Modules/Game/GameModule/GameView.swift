import SwiftUI

struct GameView: View {

    private enum Constants {
        static let bombPurple: Color = Color(red: 0.55, green: 0.24, blue: 0.85)
    }

    @ObservedObject var viewModel: GameViewModel

    @State var buttonName = "Запустить"
    
    var body: some View {
        NavigationView {
            ZStack {
                BombBackgroundView()
                VStack {
                    HStack(alignment: .center) {
                        Button {
                            viewModel.goBack()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text("ИГРА")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Constants.bombPurple)
                            .padding(.bottom)
                        Spacer()
                        Button {
                            viewModel.setOnPause()
                        } label: {
                            Image("pauseButton")
                        }
                    }
                    .padding()

                    Text("Нажмите")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Constants.bombPurple)
                    Text("\("Запустить") чтобы начать игру")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Constants.bombPurple)
                    Image("bomb")
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
