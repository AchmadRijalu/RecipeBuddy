//
//  RecipeModel.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import Foundation

struct RecipeModel: Identifiable, Decodable, Encodable {
    var id: String
    var title: String
    var tags: [String]
    var minutes: Int
    var image: String
    var ingredients: [IngredientModel]
    var steps: [String]
}

struct IngredientModel: Identifiable, Decodable, Encodable  {
    let id = UUID()
    let name: String
    let quantity: String

    enum CodingKeys: String, CodingKey {
        case name
        case quantity
    }
}
