

import SwiftUI

struct ProfileView: View {
    @State var isAvaAlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false
    @StateObject var viewModel: ProfileViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20){
                Image("User")
                    .resizable()
                    .frame(width: 80, height: 130)
                    .padding(2)
                    .padding(.trailing, 10)
                    .background(Color("ColorGrayAlpha"))
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvaAlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фотку?", isPresented: $isAvaAlertPresented) {
                        Button {
                            print ("Library")
                        } label: {
                            Text ("Из галереи")
                        }
                        Button {
                            print ("Camera")
                        } label: {
                            Text ("С камеры")
                        }
                    }
                
                VStack (alignment: .leading, spacing: 12) {
                    TextField("Имя", text: $viewModel.profile.name)
                        .font(.body.bold())
                    HStack {
                        Text("+7")
                        TextField("Телефон", value: $viewModel.profile.phone, format: .number)
                    }
                }
            }
            VStack (alignment: .leading, spacing: 6){
                Text("Адрес доставки:")
                    .bold()
                TextField("Ваш адрес", text: $viewModel.profile.adress)
            }
            
            // Таблица с заказами
            List {
                if viewModel.orders.count == 0 {
                    Text ("Ваши заказы тут")
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }
                
            }.listStyle(.plain)
            Button  {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .padding()
                    .padding(.horizontal)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }.padding(.leading, 120)
                .confirmationDialog("Вы уверены?", isPresented: $isQuitAlertPresented, titleVisibility: .visible) {
                    Button {
                        isAuthViewPresented.toggle()
                    } label: {
                        Text("Да")
                    }
                    
                }
            
                .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                    AuthView()
                }
            
            
        }.padding()
            .onSubmit {
                viewModel.setProfile()
            }
            .onAppear {
                self.viewModel.getProfile()
                self.viewModel.getOrders()
            }
    }
}
