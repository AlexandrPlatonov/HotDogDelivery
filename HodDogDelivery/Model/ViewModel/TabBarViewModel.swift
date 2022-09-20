

import Foundation
import FirebaseAuth

class TabBarViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
