//
//  FilterButton.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 18/11/23.
//

import SwiftUI

struct FilterButton: View {
    var body: some View {
        Image(systemName: "line.horizontal.3.decrease")
            .frame(width: 35, height: 35)
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(5)
    }
}

#Preview {
    FilterButton()
}
