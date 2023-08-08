import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoriesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var categoryData: [(text: String, imageName: String)] = [
        ("О Разном", "category1"),
        ("Спорт и Хобби", "category2"),
        ("Про Жизнь", "category3"),
        ("Знаменитости", "category4"),
        ("Искусство и Кино", "category5"),
        ("Природа", "category6")
    ]
    
    var body: some View {
        ZStack {
            BackgroundView()
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(categoryData, id: \.text) { category in
                    CategoryButton(
                        text: Binding.constant(category.text),
                        imageName: Binding.constant(category.imageName)
                    )
                }
            }
            .padding(16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Категории").font(.title).bold()
                        }
                    }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
                }
        .foregroundColor(Resources.Colors.mainPurple)
        .navigationBarBackButtonHidden(true)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(viewModel: CategoriesViewModel())
    }
}
