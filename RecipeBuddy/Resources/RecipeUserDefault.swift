//
//  Untitled.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 13/08/25.
//

import Foundation

class RecipeUserDefault {
    static let shared = RecipeUserDefault()
    
    private let defaults = UserDefaults.standard
    private let recipeKey = "savedRecipes"
    
    func saveRecipes(_ recipes: [RecipeModel]) {
        do {
            let data = try JSONEncoder().encode(recipes)
            defaults.set(data, forKey: recipeKey)
        } catch {
            print("Error saving recipes: \(error)")
        }
    }
    
    func getRecipes() -> [RecipeModel] {
        guard let data = defaults.data(forKey: recipeKey) else { return [] }
        
        do {
            return try JSONDecoder().decode([RecipeModel].self, from: data)
        } catch {
            print("Error decoding recipes: \(error)")
            return []
        }
    }
    
    func clearRecipes() {
        defaults.removeObject(forKey: recipeKey)
    }
}
