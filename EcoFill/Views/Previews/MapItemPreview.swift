//
//  LocationItemPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI
import MapKit

struct MapItemPreview: View {
  // MARK: - Properties
  var station: Station
  
  // MARK: - body
  var body: some View {
    ZStack {
      LinearGradient(colors: [.defaultSystem], startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
      // MARK: - Street info
      HStack {
        VStack(alignment: .leading,spacing: 15) {
          // Location info
          VStack(alignment: .leading,spacing:10) {
            Text(station.name)
              .font(.headline)
              .fontWeight(.semibold)
            Text(station.address)
              .font(.callout)
              .fontWeight(.medium)
              .foregroundStyle(.gray)
          }
          
          // MARK: - Fuels
          FuelsStack(station: station)
          .padding(.top,8)
          
          // MARK: - Payment methods
          HStack(spacing:8) {
            Text("Pay with: ")
              .font(.callout)
              .fontWeight(.medium)
              .foregroundStyle(.gray)
            Image("visa")
              .resizable()
              .frame(width:45,height:45)
            Text("or ")
              .font(.headline)
              .foregroundStyle(.defaultReversed)
            Image("cash")
              .resizable()
              .frame(width:45,height:45)
          }
          .padding(.top,4)
          
          // MARK: - Work time
          HStack {
            Text("Work time:")
              .font(.callout)
              .fontWeight(.medium)
              .foregroundStyle(.gray)
            Text(station.schedule)
              .font(.headline)
          }
          // MARK: - Get Direction
          Button("Get direction", systemImage: "figure.walk") {
            
          }
          .font(.headline)
          .fontWeight(.medium)
          .buttonStyle(.borderedProminent)
          .shadow(radius:8)
          .padding(.top,7)
        }// main
        Spacer()
      }
      .padding(.horizontal,20)
    }
    
  }
}

// MARK: - Preview
#Preview {
  MapItemPreview(station: .testStation)
}



//var body: some View {
//  VStack(alignment: .center, spacing:15) {
//    Text(station.name)
//      .font(.headline)
//      .foregroundStyle(.defaultReversed)
//
//    Divider()
//
//    Text(station.address)
//      .font(.subheadline)
//      .foregroundStyle(.gray)
//      .multilineTextAlignment(.leading)
//
//    Text(station.schedule)
//      .font(.callout).bold()
//      .foregroundStyle(.defaultReversed)
//      .multilineTextAlignment(.leading)
//
//    Text("A-95: \(station.address)")
//
//    Button("Get direction") {
//      // route
//    }
//    .fontWeight(.medium)
//    .tint(.blue)
//    .buttonStyle(.borderedProminent)
//    .padding(.top,15)
//  }
//}
