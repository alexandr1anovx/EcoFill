import SwiftUI

private extension SupportScreen {
  struct TextFields: View {
    @Bindable var viewModel: SupportViewModel
    var body: some View {
      VStack(spacing: 15) {
        DefaultTextField(
          title: "Email",
          iconName: "envelope",
          text: $viewModel.email
        )
        .disabled(true)
        ExtendedTextField(
          inputData: $viewModel.message,
          iconName: "message",
          hint: "Write your message",
          maxCount: 100
        )
        Text("Use polite language in your message.")
          .font(.footnote)
          .foregroundStyle(.gray)
      }
      .padding([.horizontal, .top])
    }
  }
  struct SendMessageButton: View {
    @Bindable var viewModel: SupportViewModel
    var body: some View {
      Button {
        viewModel.message = ""
        viewModel.showAlert.toggle()
      } label: {
        Text("Submit")
          .prominentButtonStyle(tint: .green)
      }
      .padding([.top, .horizontal])
      .opacity(!viewModel.isMessageCorrect ? 0.5 : 1)
      .disabled(!viewModel.isMessageCorrect)
      .alert("Done!", isPresented: $viewModel.showAlert) {
        // "OK" button by default
      } message: {
        Text("Thanks for reaching out! Whether it’s feedback or an issue, we appreciate your input and will respond shortly.")
      }
    }
  }
}

struct SupportScreen: View {
  @Environment(SessionManager.self) var sessionManager
  @State private var viewModel = SupportViewModel()
  var body: some View {
    VStack(spacing: 10) {
      TextFields(viewModel: viewModel)
      SendMessageButton(viewModel: viewModel)
      Spacer()
    }
    .padding(.top)
    .navigationTitle("Submit Your Feedback")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      retrieveUserEmail()
    }
    .onTapGesture {
      UIApplication.shared.hideKeyboard()
    }
  }
  private func retrieveUserEmail() {
    guard let user = sessionManager.currentUser else { return }
    viewModel.email = user.email
  }
}

#Preview {
  NavigationView {
    SupportScreen()
      .environment(SessionManager.mockObject)
  }
}
