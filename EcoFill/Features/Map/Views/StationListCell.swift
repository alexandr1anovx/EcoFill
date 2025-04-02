import SwiftUI
import MapKit

struct StationListCell: View {
  
  let station: Station
  @EnvironmentObject var mapViewModel: MapViewModel
  
  private let transportTypes = MKDirectionsTransportType.allCases
  private var isPresentedRoute: Bool {
    mapViewModel.selectedStation == station
    && mapViewModel.isShownRoute
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      addressLabel
      scheduleLabel
      paymentLabel
      HStack{
        routeConditionButton.buttonStyle(.plain)
        HStack(spacing: 8){
          ForEach(transportTypes, id: \.self) { transportType in
            transportLabel(for: transportType)
          }
        }
      }
    }
  }
  
  private func transportLabel(for type: MKDirectionsTransportType) -> some View {
    Image(systemName: type.iconName)
      .imageScale(.small)
      .foregroundStyle(type == mapViewModel.selectedTransportType ? .primaryLime : .gray)
      .padding(10)
      .background(.black)
      .clipShape(.circle)
      .onTapGesture {
        mapViewModel.selectedTransportType = type
      }
  }
  
  private var addressLabel: some View {
    HStack {
      Image(.marker)
        .foregroundStyle(.primaryIcon)
      Text(station.street)
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.primaryLabel)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
    }
  }
  
  private var scheduleLabel: some View {
    HStack {
      Image(.clock)
        .foregroundStyle(.primaryIcon)
      Text(station.schedule)
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.primaryLabel)
    }
  }
  
  private var paymentLabel: some View {
    HStack {
      Image(.money).foregroundStyle(.primaryIcon)
      Text("payment_label").foregroundStyle(.primaryLabel)
      Text("Cash, ApplePay.").foregroundStyle(.gray)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  @ViewBuilder
  private var routeConditionButton: some View {
    if !isPresentedRoute {
      Button {
        mapViewModel.isShownStationPreview = false
        mapViewModel.selectedStation = station
        mapViewModel.isShownRoute = true
      } label: {
        Text("show_route")
          .font(.subheadline)
          .fontWeight(.medium)
          .foregroundStyle(.black)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 12)
          .background(.primaryLime)
          .clipShape(.rect(cornerRadius: 15))
          .shadow(radius: 1)
      }
    } else {
      Button {
        mapViewModel.isShownStationPreview = false
        mapViewModel.selectedStation = nil
        mapViewModel.isShownRoute = false
      } label: {
        Text("hide_route")
          .font(.subheadline)
          .fontWeight(.medium)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 12)
          .background(.red)
          .clipShape(.rect(cornerRadius: 15))
          .shadow(radius: 1)
      }
    }
  }
}

#Preview {
  StationListCell(station: .mockStation)
    .environmentObject( MapViewModel() )
}
