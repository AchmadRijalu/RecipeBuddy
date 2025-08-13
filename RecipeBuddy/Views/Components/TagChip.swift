//
//  TagChip.swift
//  RecipeBuddy
//
//  Created by Achmad Rijalu on 12/08/25.
//

import SwiftUI

struct TagChip: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Text(text)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(16)
            .onTapGesture {
                action()
            }
    }
}

