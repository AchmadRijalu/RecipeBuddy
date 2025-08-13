//
//  ListRecipeView.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import SwiftUI
import AlertToast

struct ListRecipeView: View {
    @ObservedObject var listRecipeViewModel: ListRecipeViewModel
    @ObservedObject var favoriteRecipeViewModel: FavoriteRecipeViewModel
    @State var isShowToast: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack(spacing: 0) {
                    VStack(spacing: 16) {
                        HStack {
                            Text("What would you like to cook today?")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .font(.system(size: 16, weight: .medium))
                            
                            TextField("Search by title or ingredient", text: $listRecipeViewModel.searchText)
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
                                Color(red: 0.95, green: 0.4, blue: 0.27),
                                Color(red: 0.98, green: 0.6, blue: 0.32)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(listRecipeViewModel.allTags, id: \.self) { tag in
                                TagChip(
                                    text: tag,
                                    isSelected: listRecipeViewModel.selectedTags.contains(tag)
                                ) {
                                    if listRecipeViewModel.selectedTags.contains(tag) {
                                        listRecipeViewModel.selectedTags.remove(tag)
                                    } else {
                                        listRecipeViewModel.selectedTags.insert(tag)
                                    }
                                    listRecipeViewModel.applyFilters()
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.vertical, 16)
                    .background(Color(UIColor.systemGroupedBackground))
                    HStack {
                        Spacer()
                        Button {
                            listRecipeViewModel.isSorting.toggle()
                            listRecipeViewModel.applyFilters()
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: listRecipeViewModel.isSorting ? "arrow.up" : "arrow.down")
                                    .font(.system(size: 12, weight: .semibold))
                                Text("Sort by Time")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(Color(red: 0.95, green: 0.4, blue: 0.27))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(red: 0.95, green: 0.4, blue: 0.27).opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color(red: 0.95, green: 0.4, blue: 0.27).opacity(0.3), lineWidth: 1)
                                    )
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    if listRecipeViewModel.isLoading {
                        Spacer()
                        LoadingView()
                        Spacer()
                    } else if let errorMessage = listRecipeViewModel.errorMessage {
                        Spacer()
                        ErrorView(message: errorMessage) {
                            Task { await listRecipeViewModel.loadRecipes() }
                        }
                        Spacer()
                    } else if listRecipeViewModel.filteredRecipes.isEmpty && !listRecipeViewModel.searchText.isEmpty {
                        Spacer()
                        EmptySearchView(searchText: listRecipeViewModel.searchText)
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                RecipeList(
                                    recipes: $listRecipeViewModel.filteredRecipes, isShowToast: $isShowToast,
                                    favoriteRecipeViewModel: favoriteRecipeViewModel
                                )
                            }
                            .padding(.top, 8)
                        }
                        .background(Color(UIColor.systemGroupedBackground))
                    }
                }
                .background(Color(UIColor.systemGroupedBackground))
                .onChange(of: listRecipeViewModel.searchText) { _ in
                    listRecipeViewModel.searchRecipes()
                }
                .task {
                    await listRecipeViewModel.loadRecipes()
                }
            }
        }
    }
}

struct RecipeList: View {
    @Binding var recipes: [RecipeModel]
    @Binding var isShowToast: Bool
    @ObservedObject var favoriteRecipeViewModel: FavoriteRecipeViewModel
    
    var body: some View {
        ForEach($recipes) { recipe in
            NavigationLink(destination:
                DetailRecipeView(recipe: recipe,
                favoriteViewModel: favoriteRecipeViewModel)
            ) {
                ListRecipeItem(
                    recipe: recipe,
                    favoriteRecipeViewModel: favoriteRecipeViewModel, iShowToast: $isShowToast
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ListRecipeView(listRecipeViewModel: ListRecipeViewModel(), favoriteRecipeViewModel: FavoriteRecipeViewModel())
}
