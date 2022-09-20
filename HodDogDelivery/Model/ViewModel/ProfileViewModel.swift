

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var profile: UserDefault
    @Published var orders: [Order] = [Order]()
    init (profile: UserDefault) {
        self.profile = profile
    }
    func getOrders() {
        DataBaseService.shared.getOrders(by: AuthService.shared.currentUser!.accessibilityHint) { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                for (index, order) in self.orders.enumerated() {
                    DataBaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                        case .success(let positions):
                            self.orders[index].positions = positions
                            print(self.orders[index].cost)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                print("Всего заказов: \(orders.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func setProfile() {
        DataBaseService.shared.setProfile(user: (self.profile)) { result in
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print("Ошибка синхронизации \(error.localizedDescription)")
            }
        }
        
    }
    func getProfile() {
        DataBaseService.shared.getProfile { result in
            switch result {
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

