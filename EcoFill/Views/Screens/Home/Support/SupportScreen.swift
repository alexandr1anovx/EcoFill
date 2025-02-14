import SwiftUI

struct SupportScreen: View {
  
  @State private var emailAddress = ""
  @State private var message = ""
  @State private var isShownAlert = false
  @EnvironmentObject var userVM: UserViewModel
  
  private var isMessageCorrect: Bool {
    message.count > 10
  }
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      VStack(spacing: 20) {
        textFields
        guideLabel.padding(.horizontal)
        sendMessageButton
        Spacer()
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
      CSTextField(
        icon: .envelope,
        hint: "Your email address",
        inputData: $emailAddress
      )
      .disabled(true)
      
      CSTextField(
        icon: .message,
        hint: "At least 10 characters",
        inputData: $message
      )
      .submitLabel(.done)
    }
    .listStyle(.sidebar)
    .frame(height: 140)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 2)
  }
  
  private var guideLabel: some View {
    Text("Our support team is here to help! Please use polite and respectful language in all communications.")
      .font(.caption2)
      .foregroundStyle(.gray)
      .multilineTextAlignment(.leading)
  }
  
  private var sendMessageButton: some View {
    Button {
      message = "" // clear the message field
      isShownAlert.toggle()
    } label: {
      Text("Send message")
        .font(.callout).bold()
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    .buttonStyle(.borderedProminent)
    .tint(.accent)
    .padding(.horizontal, 20)
    .shadow(radius: 2)
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
