//
//  TravelsView.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 27/07/2023.
//

import SwiftUI

struct TravelsView: View {

    @Environment(\.presentationMode) var pres
    var body: some View {
        NavigationView {
            ZStack{
                Image("sky")
                    .resizable()
                    .ignoresSafeArea()
                Image("plane")
                    .resizable()
            }
            .opacity(0.5)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.pres.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                    }
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Ikimasho!").font(.custom("Futura", size: 20))
                        Text("le parcours").font(.custom("Futura", size: 15))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.pres.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "note.text.badge.plus")
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TravelsView_Previews: PreviewProvider {
    static var previews: some View {
        TravelsView()
    }
}
