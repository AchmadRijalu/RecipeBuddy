//
//  ContentView.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var listRecipeViewModel = ListRecipeViewModel()
    @StateObject private var favoriteRecipeViewModel = FavoriteRecipeViewModel()
    var body: some View {
        TabView {
            ListRecipeView(listRecipeViewModel: listRecipeViewModel, favoriteRecipeViewModel: favoriteRecipeViewModel).tabItem {
                Image(systemName: "list.bullet")
                Text("Recipes")
            }
            FavoriteRecipeView(favoriteRecipeViewModel: favoriteRecipeViewModel).tabItem {
                Image(systemName: "heart.fill")
                Text("Favorites")
            }
        }.preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
