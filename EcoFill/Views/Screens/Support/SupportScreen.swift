import SwiftUI

struct SupportScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @FocusState private var textFieldData: TextFieldData?
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var isPresentedAlert = false
    
    private var isCorrectMessage: Bool {
        message.count > 9
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 20) {
                    CustomTextField(
                        inputData: $email,
                        title: "Email",
                        placeholder: "The email you specified"
                    )
                    .focused($textFieldData, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { textFieldData = .message }
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    
                    CustomTextField(
                        inputData: $message,
                        title: "Message",
                        placeholder: "At least 10 characters"
                    )
                    .focused($textFieldData, equals: .message)
                    .onSubmit { textFieldData = nil }
                    .submitLabel(.done)
                    
                    BaseButton("Send feedback", .success, .cmBlue) {
                        isPresentedAlert.toggle()
                        message = ""
                        textFieldData = nil
                    }
                    .disabled(!isCorrectMessage)
                    .opacity(isCorrectMessage ? 1.0 : 0.5)
                    
                    .alert("Thanks!", isPresented: $isPresentedAlert) {
                        
                    } message: {
                        Text("Feedback was successfully sent!")
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Support")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                displayEmail()
            }
        }
    }
}

extension SupportScreen {
    private func displayEmail() {
        if let userEmail = userViewModel.currentUser?.email {
            email = userEmail
        } else {
            email = "No email address 🥺"
        }
    }
}
