

import Foundation
import FirebaseAuth


class AuthService {
    static let shared = AuthService()
    private init() {}
    private let auth = Auth.auth()
    var currentUser: User? {
        return auth.currentUser
    }
    func signOut() {
        try! auth.signOut()
    }
    
    func signUp(email: String, password: String, competion: @escaping (Result<User, Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                let userDefault = UserDefault(id: result.user.uid,
                                              name: "",
                                              phone: 0,
                                              adress: "")
                DataBaseService.shared.setProfile(user: userDefault) { resultDB in
                    switch resultDB {
                    case .success(_):
                        competion(.success(result.user))
                    case .failure(let error):
                        competion(.failure(error))
                    }
                }
            } else if let error = error {
                competion(.failure(error))
            }
        }
    }
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
