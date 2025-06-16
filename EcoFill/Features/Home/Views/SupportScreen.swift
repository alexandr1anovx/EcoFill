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
  
  // MARK: - Components
  
  private var inputViews: some View {
    Section {
      InputField(for: .emailAddress, data: $email)
      .disabled(true)
      
      InputFieldExtended(
        inputData: $message,
        iconName: "message",
        hint: "input_supportMessage",
        maxCount: 100
      )
    } header: {
      Text("support_header_message")
        .font(.callout)
        .foregroundStyle(.gray)
    } footer: {
      Text("support_footer_message")
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
    .alert("support_alert_title", isPresented: $isShownAlert) {
      // "OK" button by default
    } message: {
      Text("support_alert_message")
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
