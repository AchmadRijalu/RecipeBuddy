//
//  DetailRecipeViewModel.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import SwiftUI

class DetailRecipeViewModel: ObservableObject {
    @Published var checkedIngredients: Set<String> = []
    
    func toggleIngredient(_ ingredientName: String) {
        if checkedIngredients.contains(ingredientName) {
            checkedIngredients.remove(ingredientName)
        } else {
            checkedIngredients.insert(ingredientName)
        }
    }
    
    func isIngredientChecked(_ ingredientName: String) -> Bool {
        checkedIngredients.contains(ingredientName)
    }
}
