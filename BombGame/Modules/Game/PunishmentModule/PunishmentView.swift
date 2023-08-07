//
//  PunishmentView.swift
//  BombGame
//
//  Created by Aleksey Kosov on 07.08.2023.
//

import SwiftUI

struct PunishmentView: View {
    private enum Constants {
        static let bombPurple: Color = Color(red: 0.55, green: 0.24, blue: 0.85)
    }

    @ObservedObject var viewModel: PunishmentViewModel

    @State var startAgainButtonName = "Начать \n заново"
    @State var anotherQuestionButtonName = "Другоe \n задание"


    var body: some View {
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
                        .padding(.horizontal)
                    Spacer()
                    Button {
                        viewModel.setOnPause()
                    } label: {
                        Image("pauseButton")
                    }
                }
                .padding(.horizontal)

                Text("Проигравший выполняет задание")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Image("punishment")

                Text(viewModel.punishment.text)
                    .font(.system(size: 24, weight: .bold))
                    .lineLimit(3)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(Constants.bombPurple)
                    .multilineTextAlignment(.center)
                    .padding()

                ActionButton(text: $anotherQuestionButtonName) {
                    withAnimation {
                        viewModel.getAnotherQuestion()
                    }
                }
                .lineLimit(2)

                ActionButton(text: $startAgainButtonName) {
                    viewModel.restartGame()
                }
            }
        }
    }
}

struct PunishmentView_Previews: PreviewProvider {
    static var previews: some View {
        PunishmentView(viewModel: PunishmentViewModel(punishment: Punishment.getRandomPunishment()))
    }
}
