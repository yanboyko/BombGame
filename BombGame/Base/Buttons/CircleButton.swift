//
//  CircleButton.swift
//  BombGame
//
//  Created by Vitali Martsinovich on 2023-08-07.
//

import SwiftUI

struct CircleButton: View {
    var imageName: String
    var onTapAction: () -> ()
    
    var body: some View {
        Button {
            onTapAction()
        } label: {
            ZStack {
                Image(Resources.Image.circle)
                Image(imageName)
//                    .scaledToFit()
//                    .clipShape(Circle())
//                    .frame(width: 45, height: 45)
            }
        }
        .background(Resources.Colors.mainPurple)
        .clipShape(Circle())
        .frame(width: 58, height: 58)
    }
}
