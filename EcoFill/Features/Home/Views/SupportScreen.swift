import SwiftUI

struct SupportScreen: View {
  
  @State private var email = ""
  @State private var message = ""
  @State private var isShownAlert = false
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private var isMessageCorrect: Bool {
    message.count > 10 && message.count <= 100
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing:12) {
        inputViews
        sendButton.padding(.top)
        Spacer()
      }
      .padding(.top)
      .navigationTitle("Support")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        loadUserEmail()
      }
    }
    .onTapGesture {
      UIApplication.shared.hideKeyboard()
    }
  }
  
  // MARK: - Subviews
  
  private var inputViews: some View {
    Section {
      InputField(.email, inputData: $email)
        .disabled(true)
      
      InputFieldExtended(
        inputData: $message,
        iconName: "message",
        hint: "Write your message",
        maxCount: 100
      )
    } header: {
      Text("Submit Your Message")
        .font(.callout)
        .foregroundStyle(.gray)
    } footer: {
      Text("Use polite language in your message.")
        .font(.footnote)
        .foregroundStyle(.gray)
    }
    .padding(.horizontal)
  }
  
  private var sendButton: some View {
    Button {
      message = ""
      isShownAlert.toggle()
    } label: {
      ButtonLabel(
        title: "Submit",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .opacity(!isMessageCorrect ? 0.5 : 1)
    .disabled(!isMessageCorrect)
    .alert("Done!", isPresented: $isShownAlert) {
      // "OK" button by default
    } message: {
      Text("Thanks for reaching out! Whether it’s feedback or an issue, we appreciate your input and will respond shortly.")
    }
  }
  
  // MARK: - Private Logical Methods
  
  private func loadUserEmail() {
    email = authViewModel.currentUser?.email ?? "No email address"
  }
}

#Preview {
  SupportScreen()
    .environmentObject(AuthViewModel.previewMode)
}
