import SwiftUI

struct SupportScreen: View {
    @State private var isShownAlert: Bool = false
    @State private var email: String = ""
    @State private var message: String = ""
    @FocusState private var textFieldContent: TextFieldContent?
    @EnvironmentObject var userVM: UserViewModel
    
    private var isMessageCorrect: Bool { message.count > 10 }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 25) {
                CustomTF(
                    header: "Email",
                    placeholder: "Enter email address",
                    data: $email
                )
                .focused($textFieldContent, equals: .email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .submitLabel(.next)
                .onSubmit { textFieldContent = .feedbackMessage }
                
                CustomTF(
                    header: "Message",
                    placeholder: "At least 10 characters",
                    data: $message
                )
                .focused($textFieldContent, equals: .feedbackMessage)
                .submitLabel(.send)
                .onSubmit {
                    message = ""
                    textFieldContent = nil
                    isShownAlert.toggle()
                }
                
                Btn(title: "Send message",
                    image: "message",
                    color: .accent) {
                    // Action
                    isShownAlert.toggle()
                    message = ""
                    textFieldContent = nil
                }
                .disabled(!isMessageCorrect)
                .opacity(isMessageCorrect ? 1.0 : 0.5)
                
                Spacer()
            }
            .padding(.top, 40)
            .padding(.horizontal, 22)
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
            .alert("Thanks!", isPresented: $isShownAlert) {
                // "OK" button by default
            } message: {
                Text("Feedback was successfully sent!")
            }
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
