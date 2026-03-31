import SwiftUI

struct SignUpView: View {
    @Binding var isLoggedIn: Bool
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var showPassword: Bool = false
    @State private var showConfirmPassword: Bool = false
    
    var body: some View {
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
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    VStack(spacing: 14) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 95, height: 95)
                            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                        
                        VStack(spacing: 8) {
                            Text("Create account")
                                .font(.system(size: 30, weight: .bold))
                            
                            Text("Set up your account to save cars and explore better deals.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        InputField(
                            title: "Full Name",
                            placeholder: "Enter your full name",
                            text: $fullName,
                            systemImage: "person"
                        )
                        
                        InputField(
                            title: "Email",
                            placeholder: "Enter your email",
                            text: $email,
                            systemImage: "envelope"
                        )
                        
                        PasswordField(
                            title: "Password",
                            placeholder: "Create a password",
                            text: $password,
                            showPassword: $showPassword
                        )
                        
                        PasswordField(
                            title: "Confirm Password",
                            placeholder: "Re-enter your password",
                            text: $confirmPassword,
                            showPassword: $showConfirmPassword
                        )
                    }
                    
                    VStack(spacing: 14) {
                        Button(action: {
                            isLoggedIn = true
                        }) {
                            Text("Create Account")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        
                        Text("By creating an account, you agree to continue using CarExplorer responsibly.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let systemImage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            HStack(spacing: 12) {
                Image(systemName: systemImage)
                    .foregroundStyle(.blue)
                
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 3)
        }
    }
}

struct PasswordField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    @Binding var showPassword: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            HStack(spacing: 12) {
                Image(systemName: "lock")
                    .foregroundStyle(.blue)
                
                Group {
                    if showPassword {
                        TextField(placeholder, text: $text)
                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }
                
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 3)
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView(isLoggedIn: .constant(false))
    }
}
