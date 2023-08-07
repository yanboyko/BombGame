//
//  PunishmentView.swift
//  BombGame
//
//  Created by Aleksey Kosov on 07.08.2023.
//

import SwiftUI

struct PunishmentView: View {
    @ObservedObject var viewModel: PunishmentViewModel

    var body: some View {
        Text("Hello, World!")
    }
}

struct PunishmentView_Previews: PreviewProvider {
    static var previews: some View {
        PunishmentView(viewModel: PunishmentViewModel())
    }
}
