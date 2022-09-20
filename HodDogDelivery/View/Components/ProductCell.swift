

import SwiftUI

struct ProductCell: View {
    var product: Product
    @State var uiImage = UIImage(named: "HotDog Mexica")
    var body: some View {
        VStack (spacing: 6){
            Image(uiImage: uiImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width * 0.45)
                .clipped()
            HStack{
                Text(product.title)
                    .font(.custom("AvenirNext-bold", size: 12))
                Spacer()
                Text("\(product.price) ₽")
                    .font(.custom("AvenirNext-bold", size: 12))
            }
            .padding(.horizontal, 55)
        } .frame(width: screen.width * 0.65 , height: screen.width * 0.45)
            .padding(.trailing, -38)
            .padding(.leading, -38)
            .background(.white)
            .cornerRadius(16)
            .shadow(radius: 4)
            .onAppear {
                StorageService.shared.downloadProductImage(id: self.product.id) { result in
                    switch result {
                    case .success(let data):
                        if let img = UIImage(data: data) {
                            self.uiImage = img
                        }
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(id: "1",
                                     title: "Мексиканский",
                                     imageUrl: "not found",
                                     price: 230,
                                     descript: "Действительно острый!"))
    }
}
