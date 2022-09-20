

import SwiftUI
import Firebase
import FirebaseAuth

let screen = UIScreen.main.bounds
@main
struct HodDogDeliveryApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            if let user = AuthService.shared.currentUser {
                if user.uid == "pZPoje7ngObEWmbBKDnva4fDall1" {
                    AdminOrdersView()
                } else {
                let viewModel = TabBarViewModel(user: user)
                TabBar(viewModel: viewModel)
                }
            } else {
                AuthView()
            }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("App DelegateLounch")
        return true
    }
}
