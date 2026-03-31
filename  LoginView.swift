import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    
    @AppStorage("isLoggedIn") private var storedLogin = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showSignUp: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.16),
                        Color.white,
                        Color(.systemGroupedBackground)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Text("Welcome back")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 16) {
                            TextField("Email", text: $email)
                                .textInputAutocapitalization(.never)
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            HStack {
                                if showPassword {
                                    TextField("Password", text: $password)
                                } else {
                                    SecureField("Password", text: $password)
                                }
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(systemName: "eye")
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.subheadline)
                        }
                        
                        Button("Sign In") {
                            handleLogin()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        
                        Button("Continue as Guest") {
                            loginSuccess()
                        }
                        .foregroundStyle(.blue)
                        
                        HStack {
                            Text("Don’t have an account?")
                            Button("Create one") {
                                showSignUp = true
                            }
                        }
                        .font(.subheadline)
                    }
                    .padding()
                }
            }
            .navigationDestination(isPresented: $showSignUp) {
                SignUpView(isLoggedIn: $isLoggedIn)
            }
        }
    }
    
    // ✅ LOGIN LOGIC
    func handleLogin() {
        if email.lowercased() == "user@example.com" && password == "pass123" {
            loginSuccess()
        } else {
            errorMessage = "Invalid email or password"
        }
    }
    
    func loginSuccess() {
        storedLogin = true
        isLoggedIn = true
        errorMessage = ""
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
