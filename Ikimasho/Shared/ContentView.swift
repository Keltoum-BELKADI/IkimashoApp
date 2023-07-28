//
//  ContentView.swift
//  Shared
//
//  Created by Haaris Iqubal on 1/8/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Destination.name, ascending: true)]) private var destinations:FetchedResults<Destination>
    
    @State private var addDestination = false
    @State private var addTravel = false
    
    var body: some View {
        NavigationView {
            ZStack{
                    Image("couple")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.5)
                        .ignoresSafeArea(.all)
                List {
                    ForEach(destinations){ destination in
                        NavigationLink(destination: {
                            List{
                                ForEach(destination.travel){ travel in
                                    TravelDetailCell(travel: travel)
                                } .listRowBackground(Capsule().fill(Color.teal.gradient))
                            }
                            .background(Image("Background").resizable().ignoresSafeArea().opacity(0.5))
                            .scrollContentBackground(.hidden)
                            .accentColor(.black)
                        }, label: {
                            Text(destination.name ?? "").font(.custom("Futura", size: 20))
                        })
                        .navigationBarTitleDisplayMode(.inline)
                    }
                    .onDelete(perform: deleteDestination)
                    .listRowBackground(Capsule().fill(Color.indigo.gradient).opacity(0.8))
                }
                .scrollContentBackground(.hidden)
                .sheet(isPresented: $addDestination){
                    AddDestination()
                }
                .sheet(isPresented: $addTravel){
                    AddTravel()
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
                            Label("Ajouter une étape ", systemImage: "note.text")
                                .foregroundColor(.black)
                        })
                    }
                    ToolbarItem(placement: .principal) {
                        VStack{
                            Text("Ikimasho!").font(.custom("Futura", size: 15)).bold()
                            Text("Vos destinations").font(.custom("Futura", size: 15)).italic()
                        }
                    }
                }
            }
        }  .navigationBarBackButtonHidden(true)
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
