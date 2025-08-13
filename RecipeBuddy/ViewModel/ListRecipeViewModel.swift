//
//  ListRecipeViewModel.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import SwiftUI

@MainActor
class ListRecipeViewModel: ObservableObject {
    @Published var recipes: [RecipeModel] = []
    @Published var filteredRecipes: [RecipeModel] = []
    @Published var searchText = ""
    @Published var selectedTags: Set<String> = []
    @Published var isSorting = true
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: RecipeRepositoryProtocol
    private var searchTask: Task<Void, Never>?
    
    init(repository: RecipeRepositoryProtocol = RecipeRepository()) {
        self.repository = repository
    }
    
    var allTags: [String] {
        let tags = recipes.flatMap {$0.tags}
        return Array(Set(tags)).sorted()
    }
    
    func loadRecipes() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let loadedRecipes = try await repository.loadRecipeList()
            recipes = loadedRecipes
            applyFilters()
        } catch {
            errorMessage = "Failed to load recipes: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func searchRecipes() {
        searchTask?.cancel()
        
        searchTask = Task {
            applyFilters()
        }
    }
    
    func applyFilters() {
        var results = recipes
        
        if !searchText.isEmpty {
            let lowercasedQuery = searchText.lowercased()
            results = results.filter { recipe in
                recipe.title.lowercased().contains(lowercasedQuery) ||
                recipe.ingredients.contains { $0.name.lowercased().contains(lowercasedQuery) }
            }
        }
        
        if !selectedTags.isEmpty {
            results = results.filter { recipe in
                !Set(recipe.tags).intersection(selectedTags).isEmpty
            }
        }
        
        results.sort {
            isSorting ? $0.minutes < $1.minutes : $0.minutes > $1.minutes
        }
        
        filteredRecipes = results
    }
}
