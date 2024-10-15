import SwiftUI

struct ServiceCell: View {
    let service: Service
    
    var body: some View {
        NavigationLink {
            switch service.type {
            case .support: SupportScreen()
            }
        } label: {
            HStack(spacing: 15) {
                Image(systemName: service.image)
                    .font(.title)
                    .foregroundStyle(.accent)
                VStack(alignment: .leading, spacing: 8) {
                    Text(service.type.rawValue)
                        .font(.poppins(.medium, size: 15))
                        .foregroundStyle(.cmReversed)
                    Text(service.description)
                        .font(.poppins(.regular, size: 12))
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}
