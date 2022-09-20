

import Foundation
import UIKit

class ProductDetailViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var rollType = ["Mini", "Normal", "Big"]
    @Published var count = 0
    @Published var image = UIImage(named: "HotDog Mexica")!
    
    init (product: Product) {
        self.product = product
    }
    func getPrice(rollType: String) -> Int {
        
        switch rollType {
        case "Mini": return product.price
        case "Normal": return Int(Double(product.price) * 1.25)
        case "Big": return Int(Double(product.price) * 1.5)
        default: return 0
        }
    }
    func getImage() {
        StorageService.shared.downloadProductImage(id: product.id) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
