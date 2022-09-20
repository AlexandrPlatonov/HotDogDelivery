

import SwiftUI

struct OrderView: View {
    @StateObject var viewModel: OrderViewModel
    var statuses: [String] {
        var sts = [String]()
        for status in OrderStatus.allCases{
            sts.append(status.rawValue)
        }
        return sts
    }
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("\(viewModel.user.name)")
                .font(.title3).bold()
            Text("+7 \(viewModel.user.phone)")
                .bold()
            Text("\(viewModel.user.adress)")
        } .padding()
            .onAppear {
                viewModel.getUserData()
            }
        Picker (selection: $viewModel.order.status) {
            ForEach(statuses, id:\.self) { status in
                Text (status)
            }
        } label: {
            Text("Статус заказа")
        }
        .pickerStyle(.segmented)
        .onChange(of: viewModel.order.status) { newStatus in
            DataBaseService.shared.setOrder(order: viewModel.order) { result in
                switch result {
                case .success(let order):
                    print(order.status)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

        List {
            ForEach (viewModel.order.positions, id: \.id) { position in
                PositionCell(position: position)
            }
            Text("Итого: \(viewModel.order.cost) ₽")
                .bold()
            
        }
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(viewModel: OrderViewModel(order: Order(userID: "", date: Date(), status: "")))
    }
}
