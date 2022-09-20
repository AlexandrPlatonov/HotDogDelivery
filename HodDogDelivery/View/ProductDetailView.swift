
import SwiftUI

struct ProductDetailView: View {
    
    @State var viewModel: ProductDetailViewModel
    @State var rollType = "Normal"
    @State var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                
                Image(uiImage: self.viewModel.image)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 280)
                HStack {
                    Text("\(viewModel.product.title)")
                        .font(.title2.bold())
                    Spacer()
                    Text("\(viewModel.getPrice(rollType: self.rollType)) ₽")
                        .font(.title2)
                }.padding(.horizontal)
                Text("\(viewModel.product.descript)")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                
                HStack {
                    Stepper("Количество", value: $count, in: 1...10)
                    Text("\(self.count)")
                        .padding(.leading)
                }.padding(.horizontal)
                
                
                
                Picker("Тип булки", selection: $rollType) {
                    ForEach(viewModel.rollType, id: \.self) { item in
                        Text(item)
                    }
                } .pickerStyle(.segmented)
                    .padding()
            }
            Button {
                var position = Position(id: UUID().uuidString,
                                        product: viewModel.product,
                                        count: self.count)
                position.product.price = viewModel.getPrice(rollType: rollType)
                CartViewModel.shared.addPosition(position)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("В корзину")
                    .padding()
                    .padding(.horizontal, 60)
                    .foregroundColor(Color("DarlBrown"))
                    .font(.title3.bold())
                    .background(.linearGradient(colors: [Color("Orange"), Color("Yellow")], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
            }
            .onAppear {
                self.viewModel.getImage()
            }

            Spacer()
        }
        
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(product: Product(id: "1",
                                                                             title: "Мексиканский",
                                                                             imageUrl: "not found",
                                                                             price: 230,
                                                                             descript: "Действительно острый!")))
    }
}
