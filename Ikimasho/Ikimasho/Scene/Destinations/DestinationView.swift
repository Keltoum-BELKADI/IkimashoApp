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
            if (destination.image != nil){
                Image(uiImage: UIImage(data:destination.image!)!)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
            }
            Text(destination.name ?? "").font(.custom("Futura", size: 20)).bold()
        }
        .frame(height: 80)
    }

}
