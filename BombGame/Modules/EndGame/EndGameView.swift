import SwiftUI

struct EndGameView: View {
    @ObservedObject var viewModel: EndGameViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView(viewModel: EndGameViewModel())
    }
}
