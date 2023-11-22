//
//  PokemonModel.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 18/11/23.
//

import Foundation
import CoreData

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
    
    init(count: Int = 1,
         next: String  = "",
         results: [Pokemon] = [Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")]) {
        self.count = count
        self.next = next
        self.results = results
    }
}

struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
    
    static var samplePokemon = Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct PokemonDetail: Codable {
    let abilities: [Ability]
    let height: Int
    let id: Int
    let moves: [Move]
    let name: String
    let weight: Int
}

struct Types: Codable, Identifiable  {
    let id = UUID()
    let slot: Int
    let type: TypeClass
}

struct TypeClass: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    let frontDefault: String
    let other: Other?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}


struct PokemonTypeDetail: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let types: [String]
}
    
struct Ability: Codable, Hashable {
    let ability: AbilityClass
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - AbilityClass
struct AbilityClass: Codable, Hashable {
    let name: String
    let url: String
}


struct Move: Codable, Hashable {
    let move: MoveClass
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - MoveClass
struct MoveClass: Codable, Hashable {
    let name: String
    let url: String
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable, Hashable {
    let levelLearnedAt: Int
    let moveLearnMethod, versionGroup: MoveClass

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}
