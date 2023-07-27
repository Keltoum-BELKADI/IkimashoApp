//
//  HomeScreenView.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 27/07/2023.
//

import SwiftUI

struct HomeScreenView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Destination.name, ascending: true)],
        predicate: nil,
        animation: .default) var destinations: FetchedResults<Destination>
    @State var destination: String = ""
    @State var flag: String = ""
    @State var showingAddView = false

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
                    ForEach(destinations, id: \.self) { destination in
                        NavigationLink(destination: TravelsView()) {
                            DestinationView(textSize: 20, destination: destination)
                        }
                    }.onDelete(perform: delete)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add word", systemImage: "plus.circle")
                    }
                    .foregroundColor(.green)
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Ikimasho!").font(.custom("Futura", size: 20))
                        Text("les destinations").font(.custom("Futura", size: 15))
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                   EditButton()
                    .foregroundColor(.red)
                }
            }
            .sheet(isPresented: $showingAddView, onDismiss: {
                add()
            }, content: {
                AddNewDestinationView(flag: $flag, name: $destination)
            })
        }
        .navigationViewStyle(.columns)
        .navigationBarBackButtonHidden(true)
    }

    func resetFields() {
        destination = ""
        flag = ""
    }

    func add() {
        if (destination != "" || flag != "") {
            let newDestination = Destination(context: viewContext)
            newDestination.name = destination
            newDestination.flag = flag
            saveContext()
            resetFields()
        }
    }

    func delete(offsets: IndexSet) {
        withAnimation {
            offsets.map { destinations[$0]}.forEach(viewContext.delete)
            saveContext()
        }
    }

    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
