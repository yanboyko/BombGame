import SwiftUI

struct CategoryButton: View {
//    @State private var isChosen: Bool = false
    @Binding var isChosen: Bool  // Updated binding to track selection

    @Binding var text: String
    @Binding var imageName: String
    
    var onTapAction: (() -> ())? = nil
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 178, height: 175)
                .foregroundColor(Color(red: 0.51, green: 0.19, blue: 0.65))
                .cornerRadius(50)
                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 2)
                .shadow(color: .black.opacity(0.08), radius: 1, x: 0, y: 0)
            VStack {
                HStack {
                    if isChosen {
                        CheckmarkImage()
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 13)
            .padding(.leading, 14)
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text(text)
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(Color(red: 0.98, green: 1, blue: 0))

            }
        }
        .onTapGesture {
            isChosen.toggle()
            onTapAction?()
        }
    }
}

private struct CheckmarkImage: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
            Image(systemName: "checkmark")
                .foregroundColor(Color(red: 0.51, green: 0.19, blue: 0.65))
        }
    }
}
