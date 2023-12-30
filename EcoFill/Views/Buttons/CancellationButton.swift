import SwiftUI

struct CancellationButton: View {
  /// The closure to be executed when the button is tapped.
  var action: () -> Void
  
  var body: some View {
    Button("Скасувати") {
      action()
    }
    .buttonStyle(.borderless)
    .foregroundStyle(.red)
  }
}

#Preview {
  CancellationButton(action: {})
}
