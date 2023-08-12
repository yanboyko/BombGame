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

    
    var body: some View {
        ZStack {
            BackgroundView()
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(QuestionsBox.CategoryName.allCases.indices, id: \.self) { id in
                    let category = QuestionsBox.CategoryName.allCases[id]
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
                        text: Binding.constant(category.rawValue),
                        imageName: Binding.constant("category\(id + 1)"),
                        onTapAction: {
//                            viewModel.categoryTapped(category: category)
                        }
                    )
                }
            }
            .padding(16)
        }
        .onAppear(perform: viewModel.viewAppeared)
        .onDisappear(perform: viewModel.viewDissapeared)
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
