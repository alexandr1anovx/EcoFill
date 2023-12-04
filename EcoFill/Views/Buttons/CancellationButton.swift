/// `CancellableBtn` - Custom button with cancellation action.
///
/// Example Usage:
/// ```
/// CancellableBtn(action: {
///     // Perform cancellation action
/// })
/// ```

import SwiftUI

struct CancellationButton: View {
  /// The closure to be executed when the button is tapped.
  var action: () -> Void
  
  var body: some View {
    Button("Скасувати") {
      action()
    }
    .buttonStyle(.bordered)
    .tint(.red)
  }
}

#Preview {
  CancellationButton(action: {})
}
