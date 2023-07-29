//
//  ContentView.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 27/07/2023.
//

import SwiftUI
import CoreData

struct WelcomeView: View {
    var body: some View {
        NavigationView{
        VStack {
            ZStack {
                Image("sky")
                    .scaledToFill()

                VStack {
                    SplashAnimation()
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
