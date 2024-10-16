import SwiftUI

struct SignInScreen: View {
    
    @State private var isShownForm: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var textFieldContent: TextFieldContent?
    @EnvironmentObject var userVM: UserViewModel
    
    private var isValidForm: Bool {
        email.isValidEmail && password.count > 5
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                VStack(spacing: 15) {
                    Image(.logo).frame(height: 100)
                    
                    if isShownForm {
                        VStack(spacing: 15) {
                            
                            CustomTF(header: "Email",
                                     placeholder: "Enter your email address",
                                     data: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .focused($textFieldContent, equals: .email)
                            .submitLabel(.next)
                            .onSubmit { textFieldContent = .password }
                            
                            CustomTF(header: "Password",
                                     placeholder: "Enter your password",
                                     data: $password,
                                     isSecure: true)
                            .focused($textFieldContent, equals: .password)
                            .submitLabel(.done)
                            .onSubmit { textFieldContent = nil }
                        }
                        
                        Btn(title: "Sign In", image: "userCheckmark",color: .accent) {
                            Task {
                                await userVM.signIn(withEmail: email, password: password)
                            }
                        }
                        .disabled(!isValidForm)
                        .opacity(isValidForm ? 1.0 : 0.5)
                        
                        SignUpOptionView()
                    }
                }
                .padding(.horizontal, 20)
            }
            .ignoresSafeArea(.keyboard)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
        .alert(item: $userVM.alertItem) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  dismissButton: alert.dismissButton)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.spring(duration: 0.8)) {
                    isShownForm.toggle()
                }
            }
        }
    }
}
struct SignUpOptionView: View {
    var body: some View {
        HStack(spacing: 5) {
            Text("New member?")
                .font(.poppins(.regular, size: 14))
                .foregroundStyle(.gray)
            
            NavigationLink("Sign Up") {
                SignUpScreen()
            }
            .font(.poppins(.medium, size: 15))
            .foregroundStyle(.accent)
            
            Spacer()
        }
    }
}
