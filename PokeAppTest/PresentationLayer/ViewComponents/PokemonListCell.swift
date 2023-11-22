//
//  PokemonListCell.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 18/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonListCell: View {

    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    let pokemon: Pokemon
    let pokemonTypesDetail: PokemonTypeDetail
    let imageIndex: Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(pokemon.name.capitalized)
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                        Spacer()
                        ForEach(pokemonTypesDetail.types, id: \.self) { pokemonType in
                            PokemonTypeCell(
                                typeName: pokemonType,
                                size: 10,
                                bgColor: Color(pokemonViewModel.backgroundColor(forType: pokemonType)))
                        }
                    }
                    Spacer()
                    VStack {
                        Text("#\(String(describing: imageIndex))")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                        Spacer()
                        WebImage(url: URL(string:  "\(UrlConstants.urlArtWork)\(String(describing: imageIndex)).png"))
                            .resizable()
                            .placeholder(content: {
                                ProgressView()
                            })
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .background(Color(pokemonViewModel.backgroundColor(forType: pokemonTypesDetail.types.first ?? "")))
        }
        .frame(width: 170, height: 110)
        .cornerRadius(15)
    }
}

struct PokemonListCell_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PokemonViewModel(apiClient: ApiClientService(apiEndpoints: EndpointsAPI()))
        PokemonListCell(
            pokemon: Pokemon.samplePokemon,
            pokemonTypesDetail: PokemonTypeDetail(id: 1, name: "", types: ["grass","poison"]),
            imageIndex: 1)
        .environmentObject(viewModel)
    }
}
