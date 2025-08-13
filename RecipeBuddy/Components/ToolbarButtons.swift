//
//  T.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 13/08/25.
//

import SwiftUI

struct TopBarButtons: View {
    var dismissAction: () -> Void
    var favoriteAction: () -> Void
    var favoriteIcon: String
    var favoriteColor: Color
    
    var body: some View {
        HStack {
            Button(action: dismissAction) {
                Image(systemName: "chevron.backward")
            }
            .buttonStyle(.borderedProminent)
            .clipShape(Circle())
            .tint(.white)
            .foregroundStyle(.black)

            Spacer()

            Button(action: favoriteAction) {
                Image(systemName: favoriteIcon)
                    .foregroundColor(favoriteColor)
                    
            }
            .buttonStyle(.borderedProminent)
            .clipShape(Circle())
            .tint(.white)
            .foregroundStyle(.black)
        }.padding()
    }
}
