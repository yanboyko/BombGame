//
//  AnimationViewModel.swift
//  BombGame
//
//  Created by Alexandr Rodionov on 8.08.23.
//

import Foundation

@MainActor
class AnimationViewModel: ObservableObject {
    
    @Published var addAnimation: Bool = false
    
    func turnAnimation() {
        addAnimation.toggle()
    }
}
