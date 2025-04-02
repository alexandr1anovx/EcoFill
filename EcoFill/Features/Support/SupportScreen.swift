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
      Color.appBackground.ignoresSafeArea(.all)
      VStack(spacing: 0) {
        textFields
        sendMessageButton
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
  
  private var textFields: some View {
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
    .frame(height: 280)
    .listStyle(.insetGrouped)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 1)
  }
  
  private var sendMessageButton: some View {
    Button {
      message = ""
      isShownAlert.toggle()
    } label: {
      ButtonLabel("Send Message", textColor: .primaryText, pouring: .buttonBackground)
    }
    .opacity(!isMessageCorrect ? 0.5 : 1)
    .disabled(!isMessageCorrect)
    .alert("Thanks", isPresented: $isShownAlert) {
      // "OK" button by default
    } message: {
      Text("feedback_success_alert_message")
    }
  }
  
  // MARK: Logic Methods
  
  private func loadUserEmail() {
    email = authViewModel.currentUser?.email ?? "No email address"
  }
}

#Preview {
  SupportScreen().environmentObject(AuthViewModel())
}

