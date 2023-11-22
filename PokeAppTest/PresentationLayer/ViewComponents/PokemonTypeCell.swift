//
//  PokemonTypeCell.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 18/11/23.
//

import SwiftUI

struct PokemonTypeCell: View {
    
    var typeName: String
    var size: CGFloat
    var bgColor: Color
    
    var body: some View {
        ZStack {
            HStack {
                Text(typeName)
                    .foregroundColor(.white)
                    .font(.system(size: size))
            }
        }
        .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
        .background(bgColor)
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 32)
            .stroke(.white)
        )
        .accentColor(.blue)
        
    }
}

#Preview {
    PokemonTypeCell(typeName: "grass", size: 24, bgColor: Color.green)
}
