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
      VStack(spacing:0) {
        inputViews
        sendButton
        Spacer()
      }
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
  
  private var inputViews: some View {
    List {
      Section {
        DefaultTextField(
          inputData: $email,
          iconName: "envelope",
          hint: "input_email"
        )
        .disabled(true)
        .frame(height: 50)
        
        ExtendedTextField(
          inputData: $message,
          iconName: "message",
          hint: "input_feedback",
          maxCount: 100
        )
        .frame(height: 80)
      } header: {
        Text("feedback_section_header")
      } footer: {
        Text("feedback_section_footer")
      }
    }
    .customListStyle(height: 280, shadow: 1.0, scrollDisabled: true)
  }
  
  private var sendButton: some View {
    Button {
      message = ""
      isShownAlert.toggle()
    } label: {
      ButtonLabel(
        title: "Send",
        textColor: .white,
        pouring: .green
      )
    }
    .opacity(!isMessageCorrect ? 0.5 : 1)
    .disabled(!isMessageCorrect)
    .alert("Thanks", isPresented: $isShownAlert) {
      // "OK" button by default
    } message: {
      Text("feedback_success_alert_message")
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
