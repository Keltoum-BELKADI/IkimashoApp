//
//  TravelDetailsCell.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 28/07/2023.
//

import SwiftUI

struct TravelDetailsCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var travel: Travel

    var body: some View {
            NavigationLink {
                TravelDetailsView(travel: travel)
            } label: {
                VStack{
                    HStack{
                        if (travel.imageData != nil){
                            Image(uiImage: UIImage(data:travel.imageData!)!)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 50, height: 50)
                        }
                        VStack(alignment: .leading){
                            Text(travel.day ?? "").font(.custom("Futura", size: 20)).bold()
                            Text(travel.destinationTown ?? "").font(.custom("Futura", size: 20)).italic()
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(height: 50)
                .swipeActions(edge:.trailing){
                    Button(role:.destructive,action: {
                        deleteTravel()
                    },label:{
                        Label("Delete Employee",systemImage: "trash")
                    })
                }
            }
    }

    private func deleteTravel(){
        let travelToDelete = travel
        do{
            viewContext.delete(travelToDelete)
            try viewContext.save()
        }
        catch{
            print("Error while deleting employee \(error.localizedDescription)")
        }
    }

}
