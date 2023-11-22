//
//  PokemonDetailView.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 20/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonDetailView: View {
    
    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    var pokemon: Pokemon
    var pokemonType: PokemonTypeDetail
    var imageIndex: Int
    
    var body: some View {
        VStack {
            Text(pokemonType.name.capitalized)
                .font(.title)
            WebImage(url: URL(string: "\(UrlConstants.urlArtWork)\(String(describing: imageIndex)).png"))
                .resizable()
                .placeholder(content: {
                    ProgressView()
                })
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            GeometryReader { geometry in
                obtenerComponenteVistaDeslizable(geometry: geometry)
            }
        }
        .background(Color(pokemonViewModel.backgroundColor(forType: pokemonType.types.first ?? "")).opacity(0.5))
    }
    
    @ViewBuilder
    private func obtenerComponenteVistaDeslizable(geometry: GeometryProxy) -> some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        ForEach(pokemonType.types, id: \.self) { pokemonType in
                            PokemonTypeCell(
                                typeName: pokemonType,
                                size: 20,
                                bgColor: Color( pokemonViewModel.backgroundColor(forType: pokemonType)))
                        }
                    }
                    .padding(.top, 20)
                    HStack {
                        VStack {
                            Text(Constants.moves)
                                .font(.title)
                            ScrollView {
                                ForEach(pokemonViewModel.pokemonDetail?.moves ?? [], id: \.self) { move in
                                    Text(move.move.name)
                                }
                            }
                        }
                        .padding(.trailing, 30)
                        VStack {
                            Text(Constants.abilities)
                                .font(.title)
                            ScrollView {
                                ForEach(pokemonViewModel.pokemonDetail?.abilities ?? [], id: \.self) { abilitie in
                                    Text(abilitie.ability.name)
                                }
                            }
                        }
                        .padding(.leading, 30)
                    }
                }
                .onAppear {
                    pokemonViewModel.getPokemonDetail(pokemon: pokemon)
                    
                }
                .frame(minHeight: geometry.size.height)
                .padding(.horizontal, 24)/// Se agrega este padding para evitar el clip del scrollView
            }
            .frame(width: geometry.size.width)
            .background(Color(pokemonViewModel.backgroundColor(forType: pokemonType.types.first ?? "")))
            .cornerRadius(40, corners: [.topLeft, .topRight])
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PokemonViewModel(apiClient: ApiClientService(apiEndpoints: EndpointsAPI()))
        PokemonDetailView(pokemon: Pokemon(name: "", url: ""),
                          pokemonType: PokemonTypeDetail(id: 1, name: "bulbasaur", types: ["grass","poison"]),
                          imageIndex: 1)
        .environmentObject(viewModel)
    }
}
