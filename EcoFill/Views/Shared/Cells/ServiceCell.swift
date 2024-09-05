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
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                        .foregroundStyle(.cmReversed)
                    Text(service.description)
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .fontDesign(.rounded)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}
