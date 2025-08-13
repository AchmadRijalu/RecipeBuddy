//
//  FavoriteView.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 13/08/25.
//

import SwiftUI
import AlertToast

struct FavoriteRecipeView: View {
    @ObservedObject var favoriteRecipeViewModel: FavoriteRecipeViewModel
    @State var isShowToast: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    HStack {
                        Text("Your Favorite Recipes")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .medium))
                        
                        TextField("Search your favorites", text: $favoriteRecipeViewModel.searchText)
                            .font(.system(size: 16))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 2)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 24)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.8, green: 0.2, blue: 0.6),
                            Color(red: 0.6, green: 0.3, blue: 0.8)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                if favoriteRecipeViewModel.favoriteRecipes.isEmpty {
                    Spacer()
                    EmptyFavoriteView()
                    Spacer()
                    
                } else if favoriteRecipeViewModel.filteredFavorites.isEmpty && !favoriteRecipeViewModel.searchText.isEmpty {
                    Spacer()
                    EmptySearchView(searchText: favoriteRecipeViewModel.searchText)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach($favoriteRecipeViewModel.filteredFavorites) { recipe in
                                NavigationLink(destination: DetailRecipeView(
                                    recipe: recipe,
                                    favoriteViewModel: favoriteRecipeViewModel
                                )) {
                                    ListRecipeItem(
                                        recipe: recipe,
                                        favoriteRecipeViewModel: favoriteRecipeViewModel, iShowToast: $isShowToast
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
        }.toast(isPresenting: $isShowToast) {
            AlertToast(
                displayMode: .banner(.slide),
                type: .complete(.gray),
                title: "Favorites updated",
                subTitle: "Your favorite list has been changed"
            )
        }

    }
}

#Preview {
    FavoriteRecipeView(favoriteRecipeViewModel: FavoriteRecipeViewModel())
}
