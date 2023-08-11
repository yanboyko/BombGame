import SwiftUI

struct Category: Hashable {
    var text: String
    var imageName: String
}

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoriesViewModel
    @Environment(\.presentationMode) var presentationMode
    
//    var questionBox = QuestionsBox()
    
    @State private var selectedCount = 0

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var categoryData: [Category] = [
        Category(text: "О Разном", imageName: "category1"),
        Category(text: "Спорт и Хобби", imageName: "category2"),
        Category(text: "Про Жизнь", imageName: "category3"),
        Category(text: "Знаменитости", imageName: "category4"),
        Category(text: "Искусство и Кино", imageName: "category5"),
        Category(text: "Природа", imageName: "category6")
    ]
    
    var body: some View {
        ZStack {
            BackgroundView()
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(categoryData, id: \.text) { category in
                    CategoryButton(
                        isChosen: Binding(
                            get: { viewModel.isCategorySelected(category) },
                            set: { newValue in
                                if newValue {
                                    if selectedCount < 4 {
                                        selectedCount += 1
                                    } else {
                                        return
                                    }
                                } else {
                                    selectedCount -= 1
                                }
                                viewModel.categorySelected(category, isSelected: newValue)
                            }
                        ),
                        text: Binding.constant(category.text),
                        imageName: Binding.constant(category.imageName),
                        onTapAction: {
                            viewModel.categoryTapped(category: category)
//                ForEach(categoryData, id: \.text) { category in
//                    CategoryButton(
//                        text: Binding.constant(category.text),
//                        imageName: Binding.constant(category.imageName),
//                        onTapAction: {
//                            viewModel.categoryTapped(category: category)
                        }
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
