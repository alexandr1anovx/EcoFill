import SwiftUI

struct ServicesList: View {
    var body: some View {
        List(Service.services) { service in
            ServiceCell(service: service)
        }
        .listStyle(.plain)
        .listRowSpacing(10)
    }
}
