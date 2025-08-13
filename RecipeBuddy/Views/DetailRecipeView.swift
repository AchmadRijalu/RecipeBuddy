//
//  DetailRecipeView.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import SwiftUI
import Kingfisher

struct DetailRecipeView: View {
    @Binding var recipe: RecipeModel
    let favoriteViewModel: FavoriteRecipeViewModel
    @StateObject private var detailViewModel = DetailRecipeViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .topLeading) {
                    KFImage(URL(string: recipe.image))
                        .placeholder {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(
                                    Image(systemName: "photo")
                                        .font(.title)
                                        .foregroundColor(.gray)
                                )
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                    TopBarButtons(
                        dismissAction: { dismiss() },
                        favoriteAction: {
                            favoriteViewModel.saveFavorites(recipe: recipe)
                        },
                        favoriteIcon: favoriteViewModel.isFavorite(recipeId: recipe.id) ? "heart.fill" : "heart",
                        favoriteColor: favoriteViewModel.isFavorite(recipeId: recipe.id) ? .red : .gray
                    )
                }
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(recipe.title)
                                .font(.title)
                                .bold()
                            HStack {
                                HStack {
                                    Image(systemName: "clock")
                                    Text("\(recipe.minutes) min")
                                }
                                .foregroundColor(.secondary)
                                Spacer()
                                HStack {
                                    ForEach(recipe.tags, id: \.self) { tag in
                                        Text(tag)
                                            .font(.caption)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.blue.opacity(0.2))
                                            .cornerRadius(6)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients")
                            .font(.title2)
                            .bold()
                        
                        ForEach(recipe.ingredients) { ingredient in
                            ListIngredientItem(
                                ingredient: ingredient,
                                isChecked: detailViewModel.isIngredientChecked(ingredient.name)
                            ) {
                                detailViewModel.toggleIngredient(ingredient.name)
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Instructions")
                            .font(.title2)
                            .bold()
                        
                        ForEach(recipe.steps.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 12) {
                                Text("\(index + 1)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 24, height: 24)
                                    .background(Color.blue)
                                    .cornerRadius(12)
                                Text(recipe.steps[index])
                                    .font(.body)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                            .padding(.bottom, 4)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }.navigationBarBackButtonHidden(true)
    }
}
