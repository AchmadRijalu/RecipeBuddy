//
//  EmptyFavoriteView.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 13/08/25.
//

import SwiftUI

struct EmptyFavoriteView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.slash")
                .font(.system(size: 60, weight: .ultraLight))
                .foregroundColor(.gray)
            
            VStack(spacing: 8) {
                Text("No Favorites Yet")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text("Start exploring recipes and tap the heart icon to add them to your favorites!")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    EmptyFavoriteView()
}
