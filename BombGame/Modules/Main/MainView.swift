import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @State private var startGame = "Старт игры"
    @State private var proceedGame = "Продолжить"
    @State private var categories = "Категории"
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    Text(Resources.Text.mainScreenTitle)
                        .font(.system(size: 32, weight: .heavy))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    Text(Resources.Text.bomb)
                        .font(.system(size: 48, weight: .heavy))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Resources.Colors.mainPurple)
                    Image(Resources.Image.bomb)
                        .resizable()
                        .scaledToFit()
                    VStack {
                        ActionButton(text: $startGame, onTapAction: viewModel.startGamePressed)
                        ActionButton(text: $proceedGame, onTapAction: viewModel.proceedGamePressed)
                        ActionButton(text: $categories, onTapAction: viewModel.categoriesPressed)
                    }
                    HStack {
                        CircleButton(imageName: Resources.Image.settings, onTapAction: viewModel.settingsPressed)
                        Spacer()
                        CircleButton(imageName: Resources.Image.helpImage, onTapAction: viewModel.helpPressed)
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 50)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
