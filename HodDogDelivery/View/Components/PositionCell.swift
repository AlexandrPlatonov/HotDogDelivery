

import SwiftUI

struct PositionCell: View {
    let position: Position
    var body: some View {
        HStack {
            Text(position.product.title)
                .fontWeight(.bold)
            Spacer()
            Text("\(position.count) шт.")
            Text("\(position.cost) ₽")
                .frame(width: 90, alignment: .trailing)
        } .padding(.horizontal)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(
            position: Position(id: UUID().uuidString, product: Product(id: UUID().uuidString,
                                                                       title: "Мексиканский",
                                                                       imageUrl: "HotDog Mexica",
                                                                       price: 230,
                                                                       descript: "Действительно острый"),
                                                                       count: 3)
            )
            }
            }
