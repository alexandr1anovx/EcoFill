import SwiftUI
import MapKit

struct MapItemView: View {
  
  let station: Station
  @EnvironmentObject var mapViewModel: MapViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack(alignment: .leading, spacing: 18) {
        Spacer()
        addressLabel.padding(.leading, 15)
        scheduleLabel.padding(.leading, 15)
        paymentMethodsLabel.padding(.leading, 15)
        HStack(spacing: 8) {
          Text("transport_type")
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.primaryLabel)
          ForEach(MKDirectionsTransportType.allCases, id: \.self) { type in
            transportLabel(for: type)
          }
        }
        .padding(.horizontal,15)
        FuelStackView(for: station).padding(.horizontal, 15)
        routeButton
      }
    }
  }
  
  private func transportLabel(for type: MKDirectionsTransportType) -> some View {
    Label(type.title, systemImage: type.iconName)
      .font(.footnote)
      .fontWeight(.medium)
      .foregroundStyle(type == mapViewModel.selectedTransportType ? .black : .primaryLime)
      .padding(10)
      .background(type == mapViewModel.selectedTransportType ? .primaryLime : .black)
      .clipShape(.capsule)
      .shadow(radius: 2)
      .animation(.spring, value: mapViewModel.selectedTransportType)
      .onTapGesture {
        mapViewModel.selectedTransportType = type
      }
  }
  
  private var addressLabel: some View {
    HStack(spacing: 8) {
      Image(.marker)
        .foregroundStyle(.primaryIcon)
      Text("street_label")
        .foregroundStyle(.primaryLabel)
      Text(station.street)
        .foregroundStyle(.gray)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  private var scheduleLabel: some View {
    HStack(spacing: 8) {
      Image(.clock)
        .foregroundStyle(.primaryIcon)
      Text("schedule_label")
        .foregroundStyle(.primaryLabel)
      Text(station.schedule)
        .foregroundStyle(.gray)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  private var paymentMethodsLabel: some View {
    HStack(spacing: 8) {
      Image(.money).foregroundStyle(.primaryIcon)
      Text("payment_label")
        .foregroundStyle(.primaryLabel)
      Text("payment_methods")
        .foregroundStyle(.gray)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  @ViewBuilder
  private var routeButton: some View {
    if mapViewModel.isShownRoute {
      Button {
        mapViewModel.isShownRoute = false
      } label: {
        ButtonLabel(
          title: "hide_route",
          textColor: .white,
          pouring: .red
        )
      }
    } else {
      Button {
        mapViewModel.isShownRoute = true
      } label: {
        ButtonLabel(
          title: "show_route",
          textColor: .black,
          pouring: .primaryLime
        )
      }
    }
  }
}

#Preview {
  MapItemView(station: MockData.station)
    .environmentObject(MapViewModel())
}
