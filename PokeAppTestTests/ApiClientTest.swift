//
//  ApiClientTest.swift
//  PokeAppTestTests
//
//  Created by Giovanny Beltran on 22/11/23.
//

import XCTest
import Combine
import Alamofire
@testable import PokeAppTest

final class ApliClientTest: XCTestCase {
    
    private var cancelable: AnyCancellable?
    private var sut: PokemonApiProtocol!
    
    override func setUp() {
        super.setUp()
        sut = ApiClientMock()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetPokemonList() {
        // Given
        let expected = self.expectation(description: "Consume Web Service Response Expectation")
        // When
        self.cancelable = sut.getPokemonList().sink(receiveCompletion: { completion in
            guard case .failure(let error) = completion else { return }
            XCTFail(error.localizedDescription)
            expected.fulfill()
        },
            receiveValue: { response in
            // Then
            XCTAssertNotNil(response)
            expected.fulfill()
        })
        wait(for: [expected], timeout: 1.0)
        self.cancelable?.cancel()
    }
    
    func testGetPokemonDetail() {
        // Given
        let expected = self.expectation(description: "Consume Web Service Response Expectation")
        // When
        self.cancelable = sut.getPokemonDetail(id: 1).sink(receiveCompletion: { completion in
            guard case .failure(let error) = completion else { return }
            XCTFail(error.localizedDescription)
            expected.fulfill()
        },
            receiveValue: { response in
            // Then
            XCTAssertNotNil(response)
            expected.fulfill()
        })
        wait(for: [expected], timeout: 1.0)
        self.cancelable?.cancel()
    }
}


