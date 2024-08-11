import SwiftUI

enum FeedbackTextFieldForm {
    case email, message
}

struct SupportScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - Private Properties
    @FocusState private var feedbackTextField: FeedbackTextFieldForm?
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var isPresentedAlert = false
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 20) {
                    CustomTextField(
                        inputData: $email,
                        title: "Email",
                        placeholder: "The email you specified"
                    )
                    .focused($feedbackTextField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { feedbackTextField = .message }
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    
                    CustomTextField(
                        inputData: $message,
                        title: "Message",
                        placeholder: "At least 10 characters"
                    )
                    .focused($feedbackTextField, equals: .message)
                    .onSubmit { feedbackTextField = nil }
                    .submitLabel(.done)
                    
                    SendFeedbackButton {
                        isPresentedAlert.toggle()
                        message = ""
                        feedbackTextField = nil
                    }
                    .disabled(!isMessageSuitable)
                    .opacity(isMessageSuitable ? 1.0 : 0.5)
                    .alert("Thanks!", isPresented: $isPresentedAlert) {
                        
                    } message: {
                        Text("Feedback was successfully sent")
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Support")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let userEmail = authenticationViewModel.currentUser?.email {
                    email = userEmail
                } else {
                    email = "No email"
                }
            }
        }
    }
}

// MARK: - SupportScreen
extension SupportScreen {
    var isMessageSuitable: Bool { message.count > 9 }
}
