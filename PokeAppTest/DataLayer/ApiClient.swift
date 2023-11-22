//
//  ApiClient.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 18/11/23.
//

import Foundation
import Alamofire
import Combine

struct ApiError: Error
{
    let error: Error
}

struct CustomError: Error
{
    var code: Int
    var message: String
}

protocol PokemonApiProtocol {
    func getPokemonList() -> AnyPublisher<DataResponse<PokemonPage, ApiError>, Never>
    func getPokemonDetail(id: Int) -> AnyPublisher<DataResponse<PokemonDetail, ApiError>, Never>
}

class ApiClientService
{
    private let apiEndpoints: EndpointsAPI
    public init(apiEndpoints: EndpointsAPI) {
        self.apiEndpoints = apiEndpoints
    }
}

extension ApiClientService: PokemonApiProtocol {
    func getPokemonList() -> AnyPublisher<DataResponse<PokemonPage, ApiError>, Never> {
        guard let url = URL(string: "\(apiEndpoints.urlBase)\(apiEndpoints.pokemonListUrl)")
        else{
            
            return emptyPublisher(error: CustomError(code: 555, message: EndpointsAPI.urlNotFound))
        }
        print(url)
        return AF.request(url, method:.get)
            .proccesResponse(type: PokemonPage.self)
    }
    
    func getPokemonDetail(id: Int) -> AnyPublisher<DataResponse<PokemonDetail, ApiError>, Never> {
        guard let url = URL(string: "\(apiEndpoints.urlBase)\(apiEndpoints.pokemonDetailUrl + String(id))")
        else{
            
            return emptyPublisher(error: CustomError(code: 555, message: EndpointsAPI.urlNotFound))
        }
        print(url)
        return AF.request(url, method:.get)
            .proccesResponse(type: PokemonDetail.self)
    }
    
    private func emptyPublisher<T: Decodable>(error:CustomError) -> AnyPublisher<DataResponse<T, ApiError>, Never>
    {
        return Just<DataResponse<T, ApiError>>(
            DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: .failure(ApiError(error: error)))).eraseToAnyPublisher()
    }
}

extension DataRequest
{
    func proccesResponse<T: Codable>(type: T.Type) -> AnyPublisher<DataResponse<T, ApiError>, Never> {
        validate().publishDecodable(type: type.self)
            .map{response in
                response.mapError { error in
                    return ApiError(error: error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
