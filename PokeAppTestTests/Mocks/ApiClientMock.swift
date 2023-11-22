//
//  ApiClientMock.swift
//  PokeAppTestTests
//
//  Created by Giovanny Beltran on 22/11/23.
//

import XCTest
import Combine
import Alamofire
@testable import PokeAppTest

final class ApiClientMock {
    static var error: Error?
    static var pokemonListResponse: AnyPublisher<DataResponse<PokemonPage, ApiError>, Never>!
    static var pokemonDetailResponse: AnyPublisher<DataResponse<PokemonDetail, ApiError>, Never>!
}

extension ApiClientMock: PokemonApiProtocol {
    
    func getPokemonList() -> AnyPublisher<Alamofire.DataResponse<PokeAppTest.PokemonPage, PokeAppTest.ApiError>, Never> {
        
        var getPokemonList: AnyPublisher<DataResponse<PokemonPage, ApiError>, Never>!
        
        let responseIn: DataResponse<PokemonPage, ApiError> = DataResponse<PokemonPage, ApiError>(
            request: nil,
            response: nil,
            data: nil,
            metrics: nil,
            serializationDuration: 0,
            result: .success(PokemonPage())
        )
        
        getPokemonList = Just(responseIn).eraseToAnyPublisher()
        
        if ApiClientMock.pokemonListResponse != nil {
            getPokemonList = ApiClientMock.pokemonListResponse
        }
        
        let publicador = CurrentValueSubject<AnyPublisher<DataResponse<PokemonPage, ApiError>, Never>?, Error>(getPokemonList)
        
        if let error = ApiClientMock.error {
            publicador.send(completion: .failure(error))
        }
        
        return getPokemonList
        
    }
    
    func getPokemonDetail(id: Int) -> AnyPublisher<Alamofire.DataResponse<PokeAppTest.PokemonDetail, PokeAppTest.ApiError>, Never> {
        
        var getPokemonDetail: AnyPublisher<DataResponse<PokemonDetail, ApiError>, Never>!
        
        let responseIn: DataResponse<PokemonDetail, ApiError> = DataResponse<PokemonDetail, ApiError>(
            request: nil,
            response: nil,
            data: nil,
            metrics: nil,
            serializationDuration: 0,
            result: .success(PokemonDetail(
                abilities: [Ability(
                    ability: AbilityClass(
                        name: "", url: ""),
                    isHidden: true, slot: 0)],
                height: 0,
                id: 0,
                moves: [
                    Move(move: MoveClass(
                        name: "", url: ""),
                         versionGroupDetails: [
                            VersionGroupDetail(
                                levelLearnedAt: 0,
                                moveLearnMethod: MoveClass(
                                    name: "", url: ""),
                                versionGroup: MoveClass(
                                    name: "", url: ""))])],
                name: "",
                weight: 0))
        )
        
        getPokemonDetail = Just(responseIn).eraseToAnyPublisher()
        
        if ApiClientMock.pokemonListResponse != nil {
            getPokemonDetail = ApiClientMock.pokemonDetailResponse
        }
        
        let publicador = CurrentValueSubject<AnyPublisher<DataResponse<PokemonDetail, ApiError>, Never>?, Error>(getPokemonDetail)
        
        if let error = ApiClientMock.error {
            publicador.send(completion: .failure(error))
        }
        
        return getPokemonDetail
        
    }
}
