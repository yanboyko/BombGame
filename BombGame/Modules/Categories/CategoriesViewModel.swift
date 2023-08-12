import Foundation

final class CategoriesViewModel: ObservableObject {
    @Published var selectedCategories: Set<QuestionsBox.CategoryName> = []
    @Published var selectedQuestions: [QuestionWithCategory] = []


    var questionBox = QuestionsBox()
    var maxSelectedCategories = 4
    
    // Check if a category is selected
    func isCategorySelected(_ category: QuestionsBox.CategoryName) -> Bool {
      selectedCategories.contains(category)
    }
    
    // Handle category selection and adding questions to the array
    func categorySelected(_ category: QuestionsBox.CategoryName, isSelected: Bool) {
        if isSelected {
            selectedCategories.insert(category)
            let selectedQuestionsForCategory = questionBox.questionsAndCategories
            selectedQuestions.append(contentsOf: selectedQuestionsForCategory)
            print("categories count \(selectedCategories.count)")

        } else {
            if selectedCategories.count > 1 {
                selectedCategories.remove(category)
            }
            
            selectedQuestions.removeAll { $0.category == category }
            print("categories count \(selectedCategories.count)")
        }
        
        saveCategories(categories: Array(selectedCategories))
    }

    func viewDissapeared() {
        let categories = Array(selectedCategories)
        saveCategories(categories: categories)
    }

    func viewAppeared() {
        let fetchedCategories: [QuestionsBox.CategoryName] = fetchCategories()
        self.selectedCategories = Set(fetchedCategories)
    }

    func saveCategories(categories: [QuestionsBox.CategoryName]) {
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
