import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @State private var startGame = "Старт игры"
    @State private var proceedGame = "Продолжить"
    @State private var categories = "Категории"
    
    @State private var showCategoriesScreen = false
    @State private var showGameScreen = false
    @State private var showHelpScreen = false
    
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
                    Image(Resources.Image.bombForMain)
                        .resizable()
                        .scaledToFit()
                    VStack {
                        ActionButton(text: $startGame, onTapAction: {
                            showGameScreen = true
                        })
                        ActionButton(text: $proceedGame, onTapAction: viewModel.proceedGamePressed)
                        ActionButton(text: $categories, onTapAction: {
                            showCategoriesScreen = true }
                        )
                    }
                    HStack {
                        CircleButton(imageName: Resources.Image.settings, onTapAction: viewModel.settingsPressed)
                        Spacer()
                        CircleButton(imageName: Resources.Image.helpImage, onTapAction: {
                            showHelpScreen = true
                        })
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 50)
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
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
