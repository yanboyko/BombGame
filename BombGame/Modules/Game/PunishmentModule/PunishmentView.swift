//
//  PunishmentView.swift
//  BombGame
//
//  Created by Aleksey Kosov on 07.08.2023.
//

import SwiftUI

struct PunishmentView: View {
    @ObservedObject var viewModel: PunishmentViewModel
   
    @State var startAgainButtonName = "Начать \n заново"
    @State var anotherQuestionButtonName = "Другоe \n задание"
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack(alignment: .center) {
                    Button {
                        presentationMode.wrappedValue.dismiss()

                    } label: {
                        Image(systemName: Resources.Image.back)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("ИГРА")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Resources.Colors.mainPurple)
                        .padding(.horizontal)
                    Spacer()
                    Button {
                        viewModel.setOnPause()
                    } label: {
                        Image(Resources.Image.pause)
                    }
                }
                .padding(.horizontal)

                Text("Проигравший выполняет задание")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Image(Resources.Image.punishment)

                Text(viewModel.punishment.text)
                    .font(.system(size: 24, weight: .bold))
                    .lineLimit(3)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(Resources.Colors.mainPurple)
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
        PunishmentView(viewModel: PunishmentViewModel())
    }
}
