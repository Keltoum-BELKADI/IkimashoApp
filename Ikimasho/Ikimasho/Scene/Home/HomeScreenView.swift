//
//  HomeScreenView.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 27/07/2023.
//

import SwiftUI

struct HomeScreenView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Destination.name, ascending: true)]) private var destinations:FetchedResults<Destination>

    @State private var addDestination = false
    @State private var addTravel = false

    var body: some View {
        NavigationView {

            ZStack{
                VStack {
                    Image("vac")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("vac2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("vac3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .opacity(0.5)
            List {
                ForEach(destinations, id: \.self){ destination in
                    NavigationLink(destination: {
                        List{
                            ForEach(destination.wrappedTravels, id: \.self){ travel in
                                TravelDetailsCell(travel: travel)

                            }.listRowBackground(Capsule().fill(Color.white).padding(2))
                        }
                        .scrollContentBackground(.hidden)

                        .background(Image("couple").resizable().ignoresSafeArea().opacity(0.5))
                    }, label: {
                        DestinationView(textSize: 20, destination: destination)
                    })

                }
                .onDelete(perform: deleteDestination)
            }
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $addDestination){
                AddNewDestinationView()
            }
            .sheet(isPresented: $addTravel){
                AddNewTravelView()
            }
            .toolbar {
                ToolbarItemGroup(placement:.navigationBarTrailing){
                    Button(action: {
                        addDestination.toggle()
                    }, label: {
                        Label("Ajouter une destination",systemImage: "plus.circle")
                            .foregroundColor(.green)
                    })
                    Button(action: {
                        addTravel.toggle()
                    }, label: {
                        Label("ajouter un parcours", systemImage: "note.text")
                            .foregroundColor(.black)
                    })
                }
                ToolbarItem(placement: .principal) {
                    Text("Vos destinations").font(.custom("Futura", size: 15)).bold()
                }
            }
            }
        }
        .navigationBarBackButtonHidden(true)
    }


    private func deleteDestination(at offset:IndexSet){
        for index in offset{
            let destinationToDelete = destinations[index]
            do{
                viewContext.delete(destinationToDelete)
                try viewContext.save()
            }catch{
                print("Error while deleting Department \(error.localizedDescription)")
            }
        }
    }

}
