import SwiftUI

struct SupportScreen: View {
  
  @State private var email = ""
  @State private var message = ""
  @State private var isShownAlert = false
  @EnvironmentObject var userVM: UserViewModel
  
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
          hint: "Your email address"
        )
        .disabled(true)
        .frame(height: 50)
        
        ExtendedTextField(
          inputData: $message,
          iconName: "message",
          hint: "Write your feedback...",
          maxCount: 100
        )
        .frame(height: 80)
      } header: {
        Text("Send your feedback")
      } footer: {
        Text("Our support team is here to help! Please use polite and respectful language in all communications.")
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
    .alert("Thanks!", isPresented: $isShownAlert) {
      // "OK" button by default
    } message: {
      Text("Feedback was successfully sent!")
    }
  }
  
  // MARK: - Data Methods
  private func loadUserEmail() {
    email = userVM.currentUser?.email ?? "No email address"
  }
}

#Preview {
  SupportScreen().environmentObject(UserViewModel())
}
