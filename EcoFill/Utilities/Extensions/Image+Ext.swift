import SwiftUI

extension Image {
    var navigationBarImageSize: some View {
        self
            .resizable()
            .frame(width: 32, height: 32)
    }
    var defaultImageSize: some View {
        self
            .resizable()
            .frame(width: 23, height: 23)
    }
}
