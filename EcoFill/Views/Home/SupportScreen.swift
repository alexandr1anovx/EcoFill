import SwiftUI

struct SupportScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var fieldData: TextFieldData?
    @State private var isPresentedAlert = false
    
    @State private var email = ""
    @State private var message = ""
    
    private var isMessageCorrect: Bool {
        message.count > 10
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
                    .focused($fieldData, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { fieldData = .message }
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    
                    CustomTextField(
                        inputData: $message,
                        title: "Message",
                        placeholder: "At least 10 characters"
                    )
                    .focused($fieldData, equals: .message)
                    .onSubmit { fieldData = nil }
                    .submitLabel(.done)
                    
                    BaseButton("Send feedback", .success, .cmBlue) {
                        isPresentedAlert.toggle()
                        message = ""
                        fieldData = nil
                    }
                    .disabled(!isMessageCorrect)
                    .opacity(isMessageCorrect ? 1.0 : 0.5)
                    
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
                setEmailToTextField()
            }
        }
    }
}

private extension SupportScreen {
    func setEmailToTextField() {
        if let userEmail = userVM.currentUser?.email {
            email = userEmail
        } else {
            email = "Invalid email address"
        }
    }
}
