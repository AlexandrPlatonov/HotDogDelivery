
import Foundation
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()
    private init () {}
    
    private var storage = Storage.storage().reference()
    private var productsRef: StorageReference {
        storage.child("products")
    }
    
    func upload(id: String, image: Data, completion: @escaping (Result<String, Error>) -> ()) {
        let metdata = StorageMetadata()
        metdata.contentType = "image/jpg"
        
        productsRef.child(id).putData(image, metadata: metdata) {metdata, error in
            guard let metdata = metdata else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(" Размер полученного изображения: \(metdata.size)"))
        }
    }
    func downloadProductImage(id: String, completion: @escaping (Result<Data, Error>) -> ()) {
        productsRef.child(id).getData(maxSize: 2 * 1024 * 1024) { data, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
    }
}
