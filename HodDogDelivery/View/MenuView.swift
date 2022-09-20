

import SwiftUI

struct MenuView: View {
    let layoutForNew = [GridItem(.adaptive(minimum: screen.width / 2.4))]
    let layoutForPopular = [GridItem(.adaptive(minimum: screen.width / 2.2))]
    @StateObject var viewModel = MenuViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Section("Популярные") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutForPopular, spacing: 15) {
                        ForEach(MenuViewModel.shared.popularProducts, id: \.id) { item in
                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                            
                        }
                    } .padding()
                }
            }
            Section("Новинки") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutForNew) {
                        ForEach(viewModel.newProducts, id: \.id) { item in
                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    } .padding()
                }
                
            }
        }.navigationTitle(Text("Меню"))
            .onAppear {
                viewModel.getProducts()
            }
        
    }
}
struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
