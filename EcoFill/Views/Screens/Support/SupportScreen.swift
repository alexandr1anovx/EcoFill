import SwiftUI

struct SupportScreen: View {
  
  @State private var emailAddress = ""
  @State private var message = ""
  @State private var isShownAlert = false
  @EnvironmentObject var userVM: UserViewModel
  
  private var isMessageCorrect: Bool {
    message.count > 10 && message.count < 500
  }
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      VStack(spacing:0) {
        textFields
        sendMessageButton
      }
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
  
  private var textFields: some View {
    List {
      Section {
        CSTextField(
          icon: .envelope,
          hint: "Your email address",
          inputData: $emailAddress
        )
        .disabled(true)
        
        TextFieldForMessage("At least 10 characters.", $message)
          .submitLabel(.done)
      } header: {
        Text("Send your feedback")
      } footer: {
        Text("Our support team is here to help! Please use polite and respectful language in all communications.")
      }
    }
    .listStyle(.insetGrouped)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 2)
  }
  
  private var sendMessageButton: some View {
    CSButton("Send Message", color: .accent) {
      message = ""
      isShownAlert.toggle()
    }
    .disabled(!isMessageCorrect)
    .alert("Thanks!", isPresented: $isShownAlert) {
      // "OK" button by default
    } message: {
      Text("Feedback was successfully sent!")
    }
  }
  
  // MARK: - Logic Methods
  private func displayEmailAddress() {
    if let userEmail = userVM.currentUser?.email {
      emailAddress = userEmail
    } else {
      emailAddress = "No email address"
    }
  }
}

#Preview {
  SupportScreen().environmentObject( UserViewModel() )
}
