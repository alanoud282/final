


import SwiftUI
import FirebaseAuth

struct SignUp: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var phoneNumber: String = ""
    @State private var errorMessage: String? = nil
    @State private var isSuccess: Bool = false
    @State private var showPassword = false
    @State private var showPassword2 = false
    @State private var isFormValid = false
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground(startColor: Color("CG"), endColor: Color("BG"), startPoint: .bottomTrailing, endPoint: .topLeading)
                VStack(spacing: 24) {
                    Text("Sign up")
                        .foregroundColor(Color("BG"))
                        .font(.title2)
                        .bold()
                    
                    Text("We are excited to have you join us")
                        .foregroundColor(Color.white)
                        .padding(.bottom ,30)
                    
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.secondary)
                        TextField("Email address", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .foregroundColor(email.isEmpty || isValidEmail(email) ? Color.black : Color.red)
                            .onChange(of: email) { newValue in
                                updateFormValidity()
                            }
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.secondary)
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        
                        Button(action: { self.showPassword.toggle() }) {
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.secondary)
                        if showPassword2 {
                            TextField("Confirm Password", text: $confirmPassword)
                        } else {
                            SecureField("Confirm Password", text: $confirmPassword)
                        }
                        
                        Button(action: { self.showPassword2.toggle() }) {
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    HStack(alignment: .center) {
                        Image(systemName: "phone")
                            .foregroundColor(.secondary)
                        TextField("Phone number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .onChange(of: phoneNumber) { newValue in
                                updateFormValidity()
                            }
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    if isSuccess {
                        Text("Welcome, glad you joined us")
                          
                            .foregroundColor(Color(hue: 0.352, saturation: 0.778, brightness: 0.517))
                            .padding()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button(action: signUp) {
                            Text("Sign Up")
                                .font(.title2)
                                .padding(16)
                                .frame(maxWidth: .infinity)
                                .background(isFormValid ? Color("BG") : Color.gray)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .disabled(!isFormValid)
                        
                        HStack {
                            Text("Already have an account?")
                                .foregroundColor(Color.white)
                            NavigationLink(destination: Login()) {
                                Text("Sign in")
                            }
                        }
                    }
                }
                .padding(.top ,100)
                .padding(.bottom ,40)
                .padding(.horizontal ,20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func signUp() {
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isSuccess = true
                errorMessage = nil
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func updateFormValidity() {
        isFormValid = !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !phoneNumber.isEmpty && isValidEmail(email)
    }
}
 

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

