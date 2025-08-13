//
//  RecipeListItem.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import SwiftUI
import Kingfisher

struct ListRecipeItem: View {
    @Binding var recipe: RecipeModel
    let favoriteRecipeViewModel: FavoriteRecipeViewModel
    @Binding var iShowToast: Bool
    var body: some View {
        HStack {
            KFImage(URL(string: recipe.image)).resizable()
                .placeholder {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "photo")
                                .font(.title)
                                .foregroundColor(.gray)
                        )
                }
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.headline)
                    .lineLimit(2)
                
                HStack {
                    ForEach(recipe.tags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(4)
                    }
                    Spacer()
                }
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.secondary)
                    Text("\(recipe.minutes) min")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            Spacer()
            VStack(spacing: 8) {
                Button(action: {
                    favoriteRecipeViewModel.saveFavorites(recipe: recipe)
                    iShowToast = true
                }) {
                    Image(systemName: favoriteRecipeViewModel.isFavorite(recipeId: recipe.id) ? "heart.fill" : "heart")
                        .foregroundColor(favoriteRecipeViewModel.isFavorite(recipeId: recipe.id) ? .red : .gray)
                        .font(.title3)
                }

            }
        }.contentShape(Rectangle()).padding(.bottom, 12)
    }
}
