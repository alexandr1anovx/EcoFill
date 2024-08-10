import SwiftUI

struct DismissXButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(.xmark)
                .defaultImageSize
        }
    }
}
