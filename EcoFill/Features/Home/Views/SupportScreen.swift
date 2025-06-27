import SwiftUI

struct SupportScreen: View {
  
  @StateObject private var viewModel: SupportViewModel
  
  init(viewModel: SupportViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
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
        viewModel.retrieveUserEmail()
      }
    }
    .onTapGesture {
      UIApplication.shared.hideKeyboard()
    }
  }
  
  // MARK: - Subviews
  
  private var inputViews: some View {
    Section {
      InputField(.email, inputData: $viewModel.email)
        .disabled(true)
      InputFieldExtended(
        inputData: $viewModel.message,
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
      viewModel.message = ""
      viewModel.isShownMessageSentAlert.toggle()
    } label: {
      ButtonLabel(
        title: "Submit",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .opacity(!viewModel.isMessageCorrect ? 0.5 : 1)
    .disabled(!viewModel.isMessageCorrect)
    .alert("Done!", isPresented: $viewModel.isShownMessageSentAlert) {
      // "OK" button by default
    } message: {
      Text("Thanks for reaching out! Whether it’s feedback or an issue, we appreciate your input and will respond shortly.")
    }
  }
}
