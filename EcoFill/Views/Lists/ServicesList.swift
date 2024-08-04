//
//  ServicesList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import SwiftUI

struct ServicesList: View {
    var body: some View {
        List(services) { service in
            ServiceCell(service: service)
        }
        .listStyle(.plain)
        .listRowSpacing(10)
    }
}

#Preview {
    ServicesList()
}
