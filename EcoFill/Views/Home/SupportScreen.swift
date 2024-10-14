import SwiftUI

struct SupportScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var fieldData: TextFieldData?
    @State private var emailAddress = ""
    @State private var message = ""
    @State private var isPresentedAlert = false
    
    private var isMessageCorrect: Bool {
        message.count > 10
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            CustomTextField(
                inputData: $emailAddress,
                title: "Email",
                placeholder: "The email you specified"
            )
            .focused($fieldData, equals: .email)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .submitLabel(.next)
            .onSubmit { fieldData = .message }
            
            CustomTextField(
                inputData: $message,
                title: "Message",
                placeholder: "At least 10 characters"
            )
            .focused($fieldData, equals: .message)
            .submitLabel(.send)
            .onSubmit {
                message = ""
                fieldData = nil
                isPresentedAlert.toggle()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Support")
        .onAppear {
            fieldData = .message
            displayInitialEmailAddress()
        }
        .alert("Thanks!", isPresented: $isPresentedAlert) {
            // "OK" button by default
        } message: {
            Text("Feedback was successfully sent!")
        }
    }
}

private extension SupportScreen {
    func displayInitialEmailAddress() {
        if let userEmail = userVM.currentUser?.email {
            emailAddress = userEmail
        } else {
            emailAddress = "No email address"
        }
    }
}
