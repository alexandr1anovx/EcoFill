//
//  UserDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct UserDataView: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    
    // MARK: - body
    var body: some View {
        if let user = authenticationVM.currentUser {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(user.initials)
                        .font(.lexendBody)
                        .foregroundStyle(.cmReversed)
                    Row(img: .mail, text: user.email)
                        .lineLimit(2)
                }
                Spacer()
                Row(img: .location, text: user.city)
            }
            .padding(20)
        } else {
            Text("Server error.")
                .font(.lexendHeadline)
        }
    }
}
