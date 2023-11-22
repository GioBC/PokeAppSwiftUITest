//
//  Extensions.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 20/11/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        self.init(red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0)
    }
    
    /// Inicializador que entrega un color por defecto en caso de recibir un hex nulo o vacío
    init(hex: String?, colorPorDefecto: String) {
        if let hex, !hex.isEmpty {
            let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
            var color: UInt64 = 0
            scanner.scanHexInt64(&color)

            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            self.init(red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0)
        } else {
            let color = Color(hex: colorPorDefecto)
            let componentes = color.cgColor?.components
            let red = Double(componentes?.obtenerElemento(en: 0) ?? 0)
            let green = Double(componentes?.obtenerElemento(en: 1) ?? 0)
            let blue = Double(componentes?.obtenerElemento(en: 2) ?? 0)
            self.init(red: red, green: green, blue: blue)
        }
    }
}

extension Array {
    
    /// Función para obtener un elemento de un arreglo de forma segura
    func obtenerElemento(en indice: Int) -> Element? {
        if indice + 1 > count {
            return nil
        } else {
            return self[indice]
        }
    }
}

extension Bundle {
    func decode<T: Codable>(_ fileName: String) -> T {
        guard let url = url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(fileName) from bundle.")
        }
        
        guard let loadedData = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode \(fileName) from bundle.")
        }
        
        return loadedData
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
