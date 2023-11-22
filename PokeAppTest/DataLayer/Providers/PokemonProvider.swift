//
//  PokemonProvider.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 21/11/23.
//

import Foundation
import CoreData

final class PokemonProvider {
    
    static let shared = PokemonProvider()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonLocalDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func savePokemons(_ pokemons: [Pokemon]) {
        let context = persistentContainer.viewContext
        
        pokemons.forEach { pokemon in
            let entity = NSEntityDescription.entity(forEntityName: "PokemonModel", in: context)!
            let pokemonObject = NSManagedObject(entity: entity, insertInto: context)
            
            pokemonObject.setValue(pokemon.id, forKey: "id")
            pokemonObject.setValue(pokemon.name, forKey: "name")
        }
        
        do {
            try context.save()
            print("Pokemons guardados correctamente en CoreData")
        } catch {
            print("Error al guardar los Pokemons en CoreData: \(error.localizedDescription)")
        }
    }
}
