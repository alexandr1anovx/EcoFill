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
  
  // MARK: - Auxilary UI Components
  
  private var inputViews: some View {
    List {
      Section {
        DefaultTextField(
          inputData: $email,
          iconName: "envelope",
          hint: "input_email"
        )
        .listRowBackground(Color.white.opacity(0.1))
        .disabled(true)
        .frame(height: 30)
        
        ExtendedTextField(
          inputData: $message,
          iconName: "message",
          hint: "input_feedback",
          maxCount: 100
        )
        .frame(height: 70)
        .listRowBackground(Color.white.opacity(0.1))
      } header: {
        Text("feedback_section_header")
      } footer: {
        Text("feedback_section_footer")
      }
    }
    .customListStyle(scrollDisabled: true, height: 240)
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
    .padding(.horizontal)
    .opacity(!isMessageCorrect ? 0.5 : 1)
    .disabled(!isMessageCorrect)
    .alert("Message Sent", isPresented: $isShownAlert) {
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
