//
//  SettingsView.swift
//  BombGame
//
//  Created by Alexandr Rodionov on 8.08.23.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var gameview: GameViewModel
    @ObservedObject var viewModel: SettingsViewModel
    @EnvironmentObject var animationViewModel: AnimationViewModel
    
    var body: some View {
        VStack{
            
        }
        
        
        
        
        
        Button("Включить/выключить анимацию") {
            animationViewModel.turnAnimation()
        }
       
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(gameview: GameViewModel(), viewModel: SettingsViewModel())
    }
}
