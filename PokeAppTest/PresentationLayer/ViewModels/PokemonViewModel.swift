//
//  PokemonViewModel.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 18/11/23.
//

import Foundation
import Combine
import SwiftUI

class PokemonViewModel: ObservableObject {
    
    private var cancellableSet : Set<AnyCancellable> = []
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonType = [PokemonTypeDetail]()
    @Published var pokemonDetail: PokemonDetail?
    @Published var searchedText = ""
    
    private(set) var pokemonResults: [PokemonTypeDetail] = Bundle.main.decode("pokemon.json")
    
    var apiClient: ApiClientService
    
    var filteredPokemon: [Pokemon] {
        return searchedText == "" ? pokemonList : pokemonList.filter {$0.name.contains(searchedText.lowercased())}
    }
    
    init(apiClient: ApiClientService) {
        self.apiClient = apiClient
    }
    
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    func getPokemonData() {
        apiClient.getPokemonList()
            .sink{ dataResponse in
                if dataResponse.error != nil {
                    print(dataResponse.error as Any)
                } else {
                    guard let pokemonData = dataResponse.value else { return }
                    self.pokemonList = pokemonData.results
                    self.pokemonType = self.pokemonResults
                    print(self.pokemonResults)
                    PokemonProvider.shared.savePokemons(self.pokemonList)
                }
            }
            .store(in: &self.cancellableSet)
    }
    
    func getPokemonDetail(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        apiClient.getPokemonDetail(id: id)
            .sink{ dataResponse in
                if dataResponse.error != nil {
                    print(dataResponse.error as Any)
                } else {
                    guard let pokemonDetail = dataResponse.value else { return }
                    self.pokemonDetail = pokemonDetail
                }
            }
            .store(in: &self.cancellableSet)
    }
    
    func backgroundColor(forType type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "poison": return .systemPurple
        case "grass": return .systemGreen
        case "bug": return .systemGreen
        case "water": return .systemBlue
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "normal": return .systemGray
        case "ground": return .systemOrange
        case "flying": return .systemTeal
        case "fairy": return .systemPink
        default: return .systemIndigo
        }
    }
}
