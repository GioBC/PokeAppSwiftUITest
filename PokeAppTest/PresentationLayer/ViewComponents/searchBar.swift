//
//  searchBar.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 18/11/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(height: 36)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .padding(.leading, 8)
                        
                        TextField(Constants.searchPokemon, text: $searchText)
                            .padding(8)
                            .background(Color.clear)
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.clear, lineWidth: 1)
                            )
                            .padding(.leading, 1)
                    }
                }
                .padding(.horizontal, 15)
                
            }
        }
    }
}

#Preview {
    SearchBar(searchText: .constant("Test"))
}
