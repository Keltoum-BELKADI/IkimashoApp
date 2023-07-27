//
//  DestinationsDetailsView.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 27/07/2023.
//

import SwiftUI

struct DestinationView: View {
    let textSize: CGFloat

    var destination: FetchedResults<Destination>.Element

    var body: some View {
        HStack {
            Text(destination.flag ?? "🏴‍☠️")
                .bold()
                .font(.custom("Futura", size: textSize))
            Text(destination.name ?? "Japon")
                .bold()
                .font(.custom("Futura", size: textSize))
                .foregroundColor(.black)

        }
    }
}
