import Foundation

final class CategoriesViewModel: ObservableObject {
    @Published private var selectedCategories: Set<Category> = []
    var maxSelectedCategories = 4
    
    // Check if a category is selected
    func isCategorySelected(_ category: Category) -> Bool {
        selectedCategories.contains(category)
    }
    
    // Handle category selection
    func categorySelected(_ category: Category, isSelected: Bool) {
        if isSelected {
            selectedCategories.insert(category)
            print("categories count \(selectedCategories.count)")
        } else {
            selectedCategories.remove(category)
            print("categories count \(selectedCategories.count)")
        }
    }
    
    var questionBox = QuestionsBox()
    @Published var selectedQuestions: [QuestionWithCategory] = []
    
    // logic for adding questions to pool
    
    func categoryTapped(category: Category) {
        if let categoryName = QuestionsBox.CategoryName(rawValue: category.text) {
            if let existingIndex = selectedQuestions.firstIndex(where: { $0.category == categoryName }) {
                // Deselect category
                selectedQuestions.removeAll { $0.category == categoryName }
            } else {
                // Check if the maximum number of categories has been reached
                if selectedCategories.count < maxSelectedCategories {
                    // Select category and add its questions
                    let selectedQuestionsForCategory = questionBox.selectedCategory(categoryName: category.text)
                    selectedQuestions.append(contentsOf: selectedQuestionsForCategory)
                }
            }
            
            print("Selected Questions:")
            for question in selectedQuestions {
                print("\(question.category.rawValue): \(question.text)")
            }
        }
    }
}
