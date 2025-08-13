//
//  RecipeRepository.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func loadRecipeList() async throws -> [RecipeModel]
    func searchRecipeList(query: String, recipes: [RecipeModel]) async -> [RecipeModel]
}

class RecipeRepository: RecipeRepositoryProtocol {
    
    func loadRecipeList() async throws -> [RecipeModel] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        guard let url = Bundle.main.url(forResource: "Recipes", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([RecipeModel].self, from: data)
    }
    
    func searchRecipeList(query: String, recipes: [RecipeModel]) async -> [RecipeModel] {
        guard !query.isEmpty else { return recipes }
        
        let lowercasedQuery = query.lowercased()
        return recipes.filter { recipe in
            recipe.title.lowercased().contains(lowercasedQuery) ||
            recipe.ingredients.contains { $0.name.lowercased().contains(lowercasedQuery) }
        }
    }
}
