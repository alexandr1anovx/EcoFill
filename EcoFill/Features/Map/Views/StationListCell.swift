import SwiftUI
import MapKit

struct StationListCell: View {
  
  let station: Station
  private let transportTypes = MKDirectionsTransportType.allCases
  private var isPresentedRoute: Bool {
    mapViewModel.selectedStation == station
    && mapViewModel.isShownRoute
  }
  @EnvironmentObject var mapViewModel: MapViewModel
  
  // MARK: - body
  
  var body: some View {
    VStack(alignment: .leading, spacing:15) {
      addressView
      scheduleView
      paymentView
      transportationOptionsView
      routeButton
      // to prevent the entire cell from responding to a click.
        .buttonStyle(.plain)
    }
  }
  
  // MARK: - Auxilary UI Components
  
  private var addressView: some View {
    HStack(spacing:8) {
      Image(.marker)
        .foregroundStyle(.green)
      Text("street_label")
        .foregroundStyle(.gray)
      Text(station.street)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  private var scheduleView: some View {
    HStack(spacing:8) {
      Image(.clock)
        .foregroundStyle(.green)
      Text("schedule_label")
        .foregroundStyle(.gray)
      Text(station.schedule)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  private var paymentView: some View {
    HStack(spacing:8) {
      Image(.money)
        .foregroundStyle(.green)
      Text("payment_label")
        .foregroundStyle(.gray)
      Text("payment_methods")
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  private func transportLabel(for type: MKDirectionsTransportType) -> some View {
    Label(type.title, systemImage: type.iconName)
      .font(.footnote)
      .fontWeight(.medium)
      .foregroundStyle(.white)
      .padding(10)
      .background(
        type == mapViewModel.selectedTransport ? .green : .black
      )
      .clipShape(.capsule)
      .animation(.spring, value: mapViewModel.selectedTransport)
      .onTapGesture {
        mapViewModel.selectedTransport = type
      }
  }
  
  private var transportationOptionsView: some View {
    HStack {
      Text("transportation_type")
        .font(.footnote)
        .fontWeight(.medium)
      ScrollView(.horizontal) {
        HStack(spacing:8) {
          ForEach(transportTypes, id: \.self) { type in
            transportLabel(for: type)
          }
        }
      }
      .shadow(radius:3)
      .scrollIndicators(.hidden)
    }
  }
  
  @ViewBuilder
  private var routeButton: some View {
    if !isPresentedRoute {
      Button {
        mapViewModel.selectedStation = station
        mapViewModel.isShownStationPreview = false
        mapViewModel.isShownRoute = true
      } label: {
        ButtonLabelWithIcon(
          title: "show_route",
          iconName: "arrow.trianglehead.branch",
          textColor: .white,
          pouring: .green,
          verticalSpace: 12
        )
      }
    } else {
      Button {
        mapViewModel.selectedStation = nil
        mapViewModel.isShownStationPreview = false
        mapViewModel.isShownRoute = false
      } label: {
        ButtonLabelWithIcon(
          title: "hide_route",
          iconName: "x.circle.fill",
          textColor: .white,
          pouring: .red,
          verticalSpace: 12
        )
      }
    }
  }
}

#Preview {
  StationListCell(station: MockData.station)
    .environmentObject(MapViewModel.previewMode)
}
