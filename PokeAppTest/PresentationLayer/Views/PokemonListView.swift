//
//  PokemonListView.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 18/11/23.
//

import SwiftUI

struct PokemonListView: View {
    
    @ObservedObject var pokemonViewModel = PokemonViewModel(apiClient: ApiClientService(apiEndpoints: EndpointsAPI()))
    
    private let adaptativeColumns = [
        GridItem(.adaptive(minimum: 160))
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(Constants.pokedex)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 5)
                Text(Constants.description)
                    .font(.subheadline)
                HStack {
                    SearchBar(searchText: $pokemonViewModel.searchedText)
                    FilterButton()
                }
                .frame(width: 350, height: 50)
                ScrollView {
                    LazyVGrid(columns: adaptativeColumns, spacing: 10) {
                        ForEach(Array(zip(pokemonViewModel.filteredPokemon, pokemonViewModel.pokemonType)), id: \.1) { pokemon, type in
                            NavigationLink(
                                destination: PokemonDetailView(
                                    pokemon: pokemon,
                                    pokemonType: type,
                                    imageIndex: pokemonViewModel.getPokemonIndex(pokemon: pokemon))
                                .environmentObject(pokemonViewModel)) {
                                        PokemonListCell(
                                            pokemon: pokemon,
                                            pokemonTypesDetail: type,
                                            imageIndex: pokemonViewModel.getPokemonIndex(pokemon: pokemon))
                                        .environmentObject(pokemonViewModel)
                                        
                                    }
                        }
                    }
                }
                Spacer()
                
            }
            .padding()
            .onAppear {
                pokemonViewModel.getPokemonData()
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
