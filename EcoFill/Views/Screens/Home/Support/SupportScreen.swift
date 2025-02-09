import SwiftUI

struct SupportScreen: View {
  
  @State private var isShownAlert = false
  @State private var emailAddress = ""
  @State private var message = ""
  @FocusState private var fieldContent: UserDataTextFieldContent?
  @EnvironmentObject var userVM: UserViewModel
  
  private var isMessageCorrect: Bool {
    message.count > 10
  }
  
  // MARK: - body
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      
      formStack
        .padding(.top, 20)
        .padding(.horizontal, 15)
        .navigationTitle("Support")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            ReturnButton()
          }
        }
        .onAppear {
          displayEmailAddress()
        }
    }
  }
  
  // MARK: - Form Stack
  private var formStack: some View {
    VStack(alignment: .leading, spacing: 25) {
      CSTextField(
        header: "Email",
        placeholder: "Enter email address",
        data: $emailAddress
      )
      .focused($fieldContent, equals: .emailAddress)
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .autocorrectionDisabled(true)
      .submitLabel(.next)
      .onSubmit { fieldContent = .supportMessage }
      
      CSTextField(
        header: "Message",
        placeholder: "At least 10 characters",
        data: $message
      )
      .focused($fieldContent, equals: .supportMessage)
      .submitLabel(.done)
      .onSubmit {
        message = ""
        fieldContent = nil
        isShownAlert.toggle()
      }
      
      CSButton(title: "Send message", image: "message", color: .accent) {
        isShownAlert.toggle()
        message = ""
        fieldContent = nil
      }
      .disabled(!isMessageCorrect)
      .opacity(isMessageCorrect ? 1 : 0.5)
      .alert("Thanks!", isPresented: $isShownAlert) {
        // "OK" button by default
      } message: {
        Text("Feedback was successfully sent!")
      }
      
      Spacer()
    }
  }
  
  // MARK: - Display Email Address Method
  private func displayEmailAddress() {
    if let userEmail = userVM.currentUser?.email {
      emailAddress = userEmail
    } else {
      emailAddress = "No email address"
    }
  }
}
