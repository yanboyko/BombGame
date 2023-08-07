import SwiftUI
// вьюшка для правил игры
struct topRulesView: View {
    
    var numberString = ""
    var text = ""
    
    var body: some View {
        HStack {
            Text(numberString)
                .foregroundColor(Resources.Colors.mainText)
                .frame(width: 29, height: 29)
                .background(Resources.Colors.mainPurple)
                .cornerRadius(50)
                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 2)
                .shadow(color: .black.opacity(0.08), radius: 1, x: 0, y: 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(.black, lineWidth: 1)
                )
            Text(text)
                .font(.system(size: 18, weight: .heavy))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct AssistanceView: View {
    @ObservedObject var viewModel: AssistanceViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var topRulesViewData: [(number: String, text: String)] = [
        ("1", "Все игроки становятся в круг."),
        ("2", "Первый игрок берет телефон и нажимает кнопку:"),
        ("3", "На экране появляется вопрос “Назовите Фрукт”."),
        ("4", "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку (правильность ответа определяют другие участники)."),
        ("5", "Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба."),
        ("6", "Проигравшим считается тот, в чьих руках взорвалась бомба."),
        ("7", "Если в настройках выбран режим игры"),
        ("7_bold", "\"С Заданиями\""),
        ("7_rest", ", то проигравший выполняет задание.")
    ]
    
    var categoryData: [(text: String, imageName: String)] = [
        ("Про Жизнь", "category3"),
        ("Знаменитости", "category4"),
        ("Искусство и Кино", "category5"),
        ("Природа", "category6")
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    Text("Правила игры")
                        .font(.system(size: 48, weight: .heavy))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Resources.Colors.mainPurple)
                    
                    ForEach(topRulesViewData.prefix(2), id: \.number) { ruleData in
                        topRulesView(numberString: ruleData.number, text: ruleData.text)
                    }
                    Text("Старт игры")
                        .frame(width: 100, height: 27)
                        .background(Resources.Colors.mainPurple)
                        .foregroundColor(Resources.Colors.mainText)
                        .font(.system(size: 16, weight: .heavy))
                        .cornerRadius(50)
                        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 2)
                        .shadow(color: .black.opacity(0.08), radius: 1, x: 0, y: 0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(.black, lineWidth: 1)
                        )
                    ForEach(topRulesViewData.suffix(7), id: \.number) { ruleData in
                        if ruleData.number == "7_bold" {
                            Text(ruleData.text)
                                .font(.system(size: 18, weight: .heavy))
                                .foregroundColor(Resources.Colors.mainPurple) // Set another color
                        } else if ruleData.number == "7_rest" {
                            Text(ruleData.text)
                                .font(.system(size: 18, weight: .heavy))
                        } else {
                            topRulesView(numberString: ruleData.number, text: ruleData.text)
                        }
                    }
                    
                    Text("Категории")
                        .font(.system(size: 48, weight: .heavy))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Resources.Colors.mainPurple)
                        .padding()
                    
                    VStack {
                        Text("В игре доступно 6 категорий и более 90 вопросов.")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 24, weight: .heavy))
                            .foregroundColor(.black)
                        
                        Text("Можно выбрать сразу несколько категорий для игры.")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 24, weight: .heavy))
                            .foregroundColor(.black)
                            .padding(.top, 50)
                        LazyVGrid(columns: columns) {
                            ForEach(categoryData, id: \.text) { category in
                                CategoryButton(
                                    text: Binding.constant(category.text),
                                    imageName: Binding.constant(category.imageName)
                                )
                                .disabled(true)
                            }
                        }
                    }
                    .padding(.all, 10)
                }
            }
        }
        .navigationTitle("Помощь")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
}

struct AssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        AssistanceView(viewModel: AssistanceViewModel())
    }
}
