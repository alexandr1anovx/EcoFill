//
//  ProductsList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct ProductsList: View {
  @State private var products = [Product]()
  @State private var isShowingProductPreview: Bool = false
  @State private var selectedProduct: Product?
  
  var body: some View {
    NavigationStack {
      if products.isEmpty {
        ContentUnavailableView("The list of products is empty.",
                               systemImage: "fuelpump",
                               description: Text("Please, check your internet connection."))
      } else {
        List(products) { product in
          ProductCell(product: product)
            .onTapGesture {
              selectedProduct = product
              isShowingProductPreview = true
            }
            .sheet(item: $selectedProduct) { product in
              ProductPreview(product: product)
            }
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .navigationTitle("Products")
        .navigationBarTitleDisplayMode(.inline)
      }
    }
    .task {
      await fetchProductData()
    }
  }
  
  func fetchProductData() async {
    guard let url = URL(string: "http://localhost:3000/products") else {
      print("Error: Invalid URL")
      return
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let decodedData = try JSONDecoder().decode([Product].self, from: data)
      products = decodedData
    } catch {
      print("Error fetching or decoding data: \(error)")
    }
  }
}

#Preview {
  ProductsList()
}
