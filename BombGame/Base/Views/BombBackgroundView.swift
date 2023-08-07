//
//  BombBackgroundView.swift
//  BombGame
//
//  Created by Aleksey Kosov on 07.08.2023.
//

import SwiftUI

struct BombBackgroundView: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.97, green: 0.97, blue: 0.04), location: 0.00),
                Gradient.Stop(color: Color(red: 1, green: 0.61, blue: 0.02).opacity(0.63), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
        .ignoresSafeArea()
    }
}

struct BombBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BombBackgroundView()
    }
}
