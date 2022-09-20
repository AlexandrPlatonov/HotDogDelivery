

import Foundation

class MenuViewModel: ObservableObject {
    static let shared = MenuViewModel()
    var popularProducts = [Product(id: "1",
                            title: "Мексиканский",
                            imageUrl: "not found",
                            price: 230,
                            descript: "Действительно острый!"),
                    Product(id: "2",
                            title: "Американский",
                            imageUrl: "not found",
                            price: 250,
                            descript: "Легендарный хот-дог мастер на американский манер!"),
                    Product(id: "3",
                            title: "Французкий",
                            imageUrl: ("not found"),
                            price: 220,
                            descript: "Самый нежный!"),
                    Product(id: "4",
                            title: "Английский",
                            imageUrl: "not found",
                            price: 270,
                            descript: "Тот самый с беконом!")
    ]
    @Published var newProducts = [Product(id: "1",
                            title: "Мексиканский",
                            imageUrl: "not found",
                            price: 230,
                            descript: "Действительно острый!"),
                    Product(id: "2",
                            title: "Американский",
                            imageUrl: "not found",
                            price: 250,
                            descript: "Легендарный хот-дог мастер на американский манер!"),
                    Product(id: "3",
                            title: "Французкий",
                            imageUrl: ("not found"),
                            price: 220,
                            descript: "Самый нежный!"),
                    Product(id: "4",
                            title: "Английский",
                            imageUrl: "not found",
                            price: 270,
                            descript: "Тот самый с беконом!")
    ]
    
    func getProducts() {
        DataBaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.newProducts = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
