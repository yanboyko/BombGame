import Foundation

final class CategoriesViewModel: ObservableObject {
    @Published private var selectedCategories: Set<Category> = []
    @Published var selectedQuestions: [QuestionWithCategory] = []
    
    var questionBox = QuestionsBox()
    var maxSelectedCategories = 4
    
    // Check if a category is selected
    func isCategorySelected(_ category: Category) -> Bool {
        selectedCategories.contains(category)
    }
    
    // Handle category selection and adding questions to the array
    func categorySelected(_ category: Category, isSelected: Bool) {
        guard let categoryName = QuestionsBox.CategoryName(rawValue: category.text) else { return }
        if isSelected {
            selectedCategories.insert(category)
            let selectedQuestionsForCategory = questionBox.selectedCategory(categoryName: category.text)
            selectedQuestions.append(contentsOf: selectedQuestionsForCategory)
            print("categories count \(selectedCategories.count)")
            
        } else {
            selectedCategories.remove(category)
            selectedQuestions.removeAll { $0.category == categoryName }
            print("categories count \(selectedCategories.count)")
        }
        let randomQuestionText = selectedQuestions.randomElement()?.text ?? "тут должен был быть случайный вопрос"
        print("random question is \(randomQuestionText)")
    }

    func viewDissapeared() {
        let categories: [QuestionsBox.CategoryName] = selectedQuestions
            .reduce(into: []) { array, question in
                if !array.contains(question.category) {
                    array.append(question.category)
                }
            }

        saveCategories(categories: categories)
    }

    private func saveCategories(categories: [QuestionsBox.CategoryName]) {
        if let encoded = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encoded, forKey: "SelectedCategories")
        }
    }

    private func fetchCategories() -> [QuestionsBox.CategoryName] {
        if let decoded = UserDefaults.standard.data(forKey: "SelectedCategories") {
            if let categories = try? JSONDecoder().decode([QuestionsBox.CategoryName].self, from: decoded) {
                return categories
            }
        }

        return []
    }
}
