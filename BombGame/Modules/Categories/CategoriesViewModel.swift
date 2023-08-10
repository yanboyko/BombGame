import Foundation

final class CategoriesViewModel: ObservableObject {
    
    var questionBox = QuestionsBox()
    @Published var selectedQuestions: [QuestionWithCategory] = []

    func categoryTapped(category: Category) {
        if let categoryName = QuestionsBox.CategoryName(rawValue: category.text) {
            if selectedQuestions.firstIndex(where: { $0.category == categoryName }) != nil {
                // Deselect category
                selectedQuestions.removeAll { $0.category == categoryName }
            } else {
                // Select category and add its questions
                let selectedQuestionsForCategory = questionBox.selectedCategory(categoryName: category.text)
                selectedQuestions.append(contentsOf: selectedQuestionsForCategory)
            }
        }
        print(selectedQuestions)
        print(selectedQuestions.randomElement()?.text ?? "тут должен был быть случайный вопрос")
    }
}
