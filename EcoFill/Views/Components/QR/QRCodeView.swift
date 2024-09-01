import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            if let user = userViewModel.currentUser {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        DataRow(image: .initials, title: user.initials)
                        DataRow(image: .mail, title: user.email)
                    }
                    Image(uiImage: generateQRCode(from: "\(user.initials)\n\(user.email)"))
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 150, height: 150)
                    
                }
                .padding(.bottom, 40)
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        DismissXButton()
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

extension QRCodeView {
    private func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(resource: .xmark)
    }
}
