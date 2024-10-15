import SwiftUI

struct SupportScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var fieldData: TextFieldData?
    @State private var email = ""
    @State private var message = ""
    @State private var isPresentedAlert = false
    
    private var isMessageCorrect: Bool {
        message.count > 10
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            CustomTextField(
                "Email",
                placeholder: "Enter your email address",
                inputData: $email
            )
            .focused($fieldData, equals: .email)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .submitLabel(.next)
            .onSubmit { fieldData = .feedbackMessage }
            
            CustomTextField(
                "Message",
                placeholder: "At least 10 characters",
                inputData: $message
            )
            .focused($fieldData, equals: .feedbackMessage)
            .submitLabel(.send)
            .onSubmit {
                message = ""
                fieldData = nil
                isPresentedAlert.toggle()
            }
            
            CustomBtn("Send message", image: "checkmark", color: .accent) {
                isPresentedAlert.toggle()
                message = ""
                fieldData = nil
            }
            .disabled(!isMessageCorrect)
            .opacity(isMessageCorrect ? 1.0 : 0.5)
            
            Spacer()
        }
        .padding(.top, 25)
        .padding(.horizontal, 20)
        .navigationTitle("Support")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackBtn()
            }
        }
        .onAppear {
            displayInitialEmailAddress()
        }
        .alert("Thanks!", isPresented: $isPresentedAlert) {
            // "OK" button by default
        } message: {
            Text("Feedback was successfully sent!")
        }
    }
    
    private func displayInitialEmailAddress() {
        if let userEmail = userVM.currentUser?.email {
            email = userEmail
        } else {
            email = "No email address"
        }
    }
}
