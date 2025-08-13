//
//  EmptyView.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import SwiftUI

struct EmptySearchView: View {
    let searchText: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("No recipes found")
                .font(.title2)
                .bold()
            
            Text("We couldn't find any recipes matching '\(searchText)'")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Text("Try searching for a different ingredient or recipe name")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    EmptySearchView(searchText: "Not Found")
}
