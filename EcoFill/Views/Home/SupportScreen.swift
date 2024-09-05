import SwiftUI

struct SupportScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var formVM: FormValidationViewModel
    @FocusState private var fieldData: TextFieldData?
    @State private var isPresentedAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 20) {
                    CustomTextField(
                        inputData: $formVM.email,
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
                        inputData: $formVM.message,
                        title: "Message",
                        placeholder: "At least 10 characters"
                    )
                    .focused($fieldData, equals: .message)
                    .onSubmit { fieldData = nil }
                    .submitLabel(.done)
                    
                    BaseButton("Send feedback", .success, .cmBlue) {
                        isPresentedAlert.toggle()
                        formVM.message = ""
                        fieldData = nil
                    }
                    .disabled(!formVM.isMessageCorrect)
                    .opacity(formVM.isMessageCorrect ? 1.0 : 0.5)
                    
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
            formVM.email = userEmail
        } else {
            formVM.email = "No email address"
        }
    }
}
