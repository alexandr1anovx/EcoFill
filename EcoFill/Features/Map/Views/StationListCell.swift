import SwiftUI
import MapKit

struct StationListCell: View {
  
  @EnvironmentObject var stationVM: StationViewModel
  let station: Station
  let transportTypes = MKDirectionsTransportType.allCases
  
  private var isPresentedRoute: Bool {
    stationVM.selectedStation == station
    && stationVM.isShownRoute
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      addressLabel
      scheduleLabel
      paymentLabel
      HStack{
        routeConditionButton.buttonStyle(.plain)
        HStack(spacing:8){
          ForEach(transportTypes, id: \.self) { transportType in
            transportTypeLabel(for: transportType)
          }
        }
      }
    }
  }
  
  private func transportTypeLabel(for type: MKDirectionsTransportType) -> some View {
    Image(systemName: type.iconName)
      .imageScale(.small)
      .foregroundStyle(type == stationVM.selectedTransportType ? .primaryLime : .gray)
      .padding(10)
      .background(.black)
      .clipShape(.circle)
      .onTapGesture {
        stationVM.selectedTransportType = type
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
      Text("Payment:").foregroundStyle(.primaryLabel)
      Text("Cash, ApplePay.").foregroundStyle(.gray)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  @ViewBuilder
  private var routeConditionButton: some View {
    if !isPresentedRoute {
      Button {
        stationVM.isShownStationDataSheet = false
        stationVM.selectedStation = station
        stationVM.isShownRoute = true
      } label: {
        Text("Show Route")
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
        stationVM.isShownStationDataSheet = false
        stationVM.selectedStation = nil
        stationVM.isShownRoute = false
      } label: {
        Text("Hide Route")
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
    .environmentObject( StationViewModel() )
}
