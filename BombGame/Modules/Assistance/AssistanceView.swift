import SwiftUI

struct AssistanceView: View {
    @ObservedObject var viewModel: AssistanceViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        AssistanceView(viewModel: AssistanceViewModel())
    }
}
