
import SwiftUI
import FirebaseAuth

struct Login: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var showPassword = false
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground(startColor: Color("CG"), endColor: Color("BG"), startPoint: .bottomTrailing, endPoint: .topLeading)

                VStack(spacing: 24){
                    Text("Login")
                        .foregroundColor(Color("BG"))
                        .font(.title2)
                        .bold()
                    Text("Welcome back")
                        .foregroundColor(Color.white)
                        .padding(.bottom ,30)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "envelope")
                            .foregroundColor(.secondary)
                        TextField("Email address", text: $email)
                           
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                    }.padding()
                        .background(Capsule().fill(Color.white))
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.secondary)
                        if showPassword {
                            TextField("Password",
                                      text: $password)
                        } else {
                            SecureField("Password",
                                        text: $password)
                        }
                        Button(action: { self.showPassword.toggle()}) {
                            
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        }
                    }   .padding()
                        .background(Capsule().fill(Color.white))
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    Spacer()
                    VStack {
                        Button(action: login) {
                            Text("Login")
                                .font(.title2)
                                .padding(16)
                                .frame(maxWidth: .infinity)
                                .background(Color("BG"))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                        }
                        .padding()
                        HStack{
                            Text("Don't have an account?")
                                .foregroundColor(Color.white)
                            NavigationLink(destination: SignUp()){
                                Text("Sign Up")
                                    .foregroundColor(Color.blue)
                            }
                        }
                    }
                }
                .padding(.top ,150)
                .padding(.bottom ,40)
                .padding(.horizontal ,20)
            }
        } .navigationBarBackButtonHidden(true)
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                print("Logged in successfully")
                
            }
        }
    }
}



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
