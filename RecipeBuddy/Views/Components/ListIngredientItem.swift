//
//  ListIngredientItem.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import SwiftUI

struct ListIngredientItem: View {
    let ingredient: IngredientModel
    let isChecked: Bool
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isChecked ? .green : .gray)
                    .font(.title2)
            }
            Text(ingredient.name)
                .strikethrough(isChecked)
                .foregroundColor(isChecked ? .secondary : .primary)
            Spacer()
            Text(ingredient.quantity)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
