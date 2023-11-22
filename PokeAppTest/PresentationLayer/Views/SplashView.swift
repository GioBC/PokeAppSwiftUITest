//
//  SplashView.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 22/11/23.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var isActive: Bool
    @State private var scale = 0.7
    
    var body: some View {
        VStack {
            Image(Constants.splashImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding()
                .onAppear{
                    withAnimation(.easeIn(duration: 0.7)) {
                        self.scale = 0.9
                    }
                }
            
            Text(Constants.welcome)
                .font(.headline)
                .foregroundColor(.black)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(isActive: .constant(false))
    }
}
