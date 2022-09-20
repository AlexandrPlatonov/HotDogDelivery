

import SwiftUI

struct AuthView: View {
    @State private var isAuth = true
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack (spacing: 20){
            Text(isAuth ? "Авторизация" : "Регистрация")
                .padding(isAuth ? 16 : 24)
                .padding(.horizontal, 40)
                .font(.title2.bold())
                .background(Color("WhiteAlpha"))
                .cornerRadius(isAuth ? 40 : 60)
                .foregroundColor(Color("DarlBrown"))
            
            VStack {
                TextField("Введите Email", text: $email)
                    .padding()
                    .background(Color("WhiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 20)
                
                SecureField("Введите пароль", text: $password)
                    .padding()
                    .background(Color("WhiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 20)
                
                if !isAuth {
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .padding()
                        .background(Color("WhiteAlpha"))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 20)
                }
                
                Button {
                    if isAuth {
                        print("Авторизация пользователя")
                        AuthService.shared.signIn(email: self.email,
                                                  password: self.password) { result in
                            switch result {
                            case.success(_):
                                isTabViewShow.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                                isShowAlert.toggle()
                            }
                        }
                        
                    } else {
                        print("Регистрация пользователя")
                        
                        guard password == confirmPassword else {
                            self.alertMessage = "Пароли не совпадают!"
                            self.isShowAlert.toggle()
                            return
                        }
                        AuthService.shared.signUp(email: self.email,
                                                  password: self.password) { result in
                            switch result {
                                
                            case .success(let user):
                                alertMessage = "Вы зарегестрировались с email \(user.email!)"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.confirmPassword = ""
                                self.isAuth.toggle()
                                
                            case .failure(let error):
                                alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                                self.isShowAlert.toggle()
                            }
                        }
                        

                    }
                }label: {
                    Text (isAuth ? "Войти" : "Создать аккаунт")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("Orange"), Color("Yellow")], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 20)
                        .font(.title3.bold())
                        .foregroundColor(Color("DarlBrown"))
                }
                
                Button {
                    isAuth.toggle()
                } label: {
                    Text (isAuth ? "Еще не с нами?" : "Уже есть аккаунт")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 20)
                        .font(.title3.bold())
                        .foregroundColor(Color("DarlBrown"))
                }
                
            }
            .padding()
            .padding(.top, 15)
            .background(Color("WhiteAlpha"))
            .cornerRadius(25)
            .padding(isAuth ? 30 : 12)
            .alert(alertMessage,
                   isPresented: $isShowAlert) {
                Button {} label: {
                    Text ("Ок")
                }
            }
            
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("Background")
                            .ignoresSafeArea()
                            .blur(radius: isAuth ? 0 : 6))
            .animation(Animation.easeOut(duration: 0.3), value: isAuth)
            .fullScreenCover(isPresented: $isTabViewShow) {
                if AuthService.shared.currentUser?.uid == "pZPoje7ngObEWmbBKDnva4fDall1" {
                    AdminOrdersView()
                } else {
                    let tabBarViewModel = TabBarViewModel(user: AuthService.shared.currentUser!)
                    TabBar(viewModel: tabBarViewModel)
                }
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .previewInterfaceOrientation(.portrait)
    }
}
