//
//  EmployeeDetailCell.swift
//  CD_One_To_Many_Relationship
//
//  Created by Haaris Iqubal on 1/8/22.
//

import SwiftUI

struct TravelDetailCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var travel: Travel
    
    
    var body: some View {
            NavigationLink {
                TravelDetailsView(travel: travel)
                    .background(Image("sky").resizable().ignoresSafeArea().opacity(0.4))
                    .scrollContentBackground(.hidden)
            } label: {
                VStack(alignment: .leading) {
                    HStack{
                        if (travel.townImageData != nil){
                            Image(uiImage: UIImage(data: travel.townImageData!)!)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60)
                        }
                        VStack(){
                            Text(travel.date ?? "")
                                .font(.custom("Futura", size: 20))
                            Text(travel.destinationTown ?? "")
                                .font(.custom("Futura", size: 20))
                                .textCase(.uppercase)

                        }
                    }
                }
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

