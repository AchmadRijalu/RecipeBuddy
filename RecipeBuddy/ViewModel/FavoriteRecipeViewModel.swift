//
//  FavoriteRecipeViewModel.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 13/08/25.
//

import SwiftUI

class FavoriteRecipeViewModel: ObservableObject {
    @Published var favoriteRecipes: [RecipeModel] = []
    @Published var filteredFavorites: [RecipeModel] = []
    @Published var searchText: String = "" {
        didSet {
            filterFavorites()
        }
    }

    private let userDefaults = RecipeUserDefault.shared

    init() {
        loadFavorites()
        filterFavorites()
    }
    
    private func filterFavorites() {
        if searchText.isEmpty {
            filteredFavorites = favoriteRecipes
        } else {
            let lowercasedQuery = searchText.lowercased()
            filteredFavorites = favoriteRecipes.filter { recipe in
                recipe.title.lowercased().contains(lowercasedQuery) ||
                recipe.ingredients.contains { $0.name.lowercased().contains(lowercasedQuery) }
            }
        }
    }

    func isFavorite(recipeId: String) -> Bool {
        favoriteRecipes.contains { $0.id == recipeId }
    }

    private func loadFavorites() {
        favoriteRecipes = userDefaults.getRecipes()
    }

    func saveFavorites(recipe: RecipeModel) {
        if let index = favoriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
            favoriteRecipes.remove(at: index)
        } else {
            favoriteRecipes.append(recipe)
        }
        userDefaults.saveRecipes(favoriteRecipes)
        filterFavorites()
    }
}
