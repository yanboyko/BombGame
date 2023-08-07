import SwiftUI

struct ActionButton: View {
    @Binding var text: String
    var onTapAction: () -> ()
    
    var body: some View {
        Button {
            onTapAction()
        } label: {
            Text(text)
                .font(.system(size: 24, weight: .heavy))
                .foregroundColor(Color(red: 0.98, green: 1, blue: 0))
              //  .frame(width: 163, height: 20.93976)
        }
        .frame(width: 274, height: 79)
        .background(Color(red: 0.51, green: 0.19, blue: 0.65))
        .cornerRadius(50)
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 2)
        .shadow(color: .black.opacity(0.08), radius: 1, x: 0, y: 0)
        .overlay(
        RoundedRectangle(cornerRadius: 50)
        .stroke(.black, lineWidth: 1))

    }
}
