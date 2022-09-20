

import SwiftUI

struct TabBar: View {
    var viewModel: TabBarViewModel
    var body: some View {
        TabView {
            NavigationView{
                MenuView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "menucard.fill")
                    Text("Меню")
                }
            }
            
            
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    VStack {
                        Image(systemName: "cart.fill")
                        Text("Корзина")
                    }
                }
            
            ProfileView(viewModel: ProfileViewModel(profile: UserDefault(id: "",
                                                                         name: "",
                                                                         phone: 000,
                                                                         adress: "")))
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Профиль")
                    }
                }
        }
    }
}


