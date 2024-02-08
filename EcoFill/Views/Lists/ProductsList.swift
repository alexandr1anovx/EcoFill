//
//  ProductsList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct ProductsList: View {
  @State private var selectedProduct: Product?
  
  @ObservedObject var dataViewModel = FirestoreDataViewModel()
  
  var body: some View {
    NavigationStack {
      if dataViewModel.products.isEmpty {
        ContentUnavailableView("The list of products is empty.",
                               systemImage: "fuelpump",
                               description: Text("Please, check your internet connection."))
      } else {
        List(dataViewModel.products) { product in
          ProductCell(product: product)
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(15)
        .navigationTitle("Products")
        .navigationBarTitleDisplayMode(.inline)
      }
    }
    .onAppear {
      dataViewModel.fetchProductsData()
    }
  }
}

#Preview {
  ProductsList()
}
