//
//  AddEmployee.swift
//  CD_One_To_Many_Relationship
//
//  Created by Haaris Iqubal on 1/8/22.
//

import SwiftUI

struct AddTravel: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var destinationTown: String = ""
    @State private var flight: String = ""
    @State private var image: UIImage = UIImage()
    @State private var hotel: String = ""
    @State private var note: String = ""
    @State private var time: String = ""
    @State private var startTown: String = ""
    @State private var train: String = ""
    @State private var date: String = ""
    @State private var checkin: String = ""
    @State private var checkout: String = ""
    @State private var imagePicker = false
    @State private var selectedDestination = Destination()
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Destination.name, ascending: true)]) private var destinations:FetchedResults<Destination>
    
    var body: some View {
        NavigationView {
            List {
                Section("Image") {
                    VStack{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .edgesIgnoringSafeArea(.all)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.gray,lineWidth: 5))
                        Button(action: {
                            imagePicker.toggle()
                        }, label: {
                            Text("Ajouter")
                        })
                            .sheet(isPresented: $imagePicker){
                                ImagePickerView(selectedImage: $image)
                            }
                    }
                }

                Section("Destination") {
                    TextFieldView(field: $date, value: "Date du départ", type: .emailAddress)
                    TextFieldView(field: $startTown, value: "Ville de départ", type: .emailAddress)
                    TextFieldView(field: $destinationTown, value: "Ville d'arrivée", type: .emailAddress)
                    TextFieldView(field: $flight, value: "Vol", type: .emailAddress)
                    TextFieldView(field: $train, value: "Shinkansen", type: .emailAddress)

                    Picker("Select Employee Department", selection: $selectedDestination){
                        ForEach(destinations,id: \.self){
                            Text($0.name ?? "").tag($0 as Destination?)
                        }
                    }
                }
                Section("Hébergement") {
                    TextFieldView(field: $hotel, value: "information hotel", type: .emailAddress)
                        .frame(height: 125)
                        .lineLimit(100)
                    TextFieldView(field: $time, value: "Durée de l'hébergement", type: .emailAddress)
                    TextFieldView(field: $checkin, value: "heure d'arrivée", type: .emailAddress)
                    TextFieldView(field: $checkout, value: "heure de départ", type: .emailAddress)
                }
                Section("Information de voyage et activités") {
                    TextEditor(text: $note)
                        .lineLimit(300)
                        .frame(height: 200)


                }

                Button(action: {
                    addTravel()
                    dismiss()
                }, label: {
                    Text("Valider")
                        .frame(width: 300, height: 40).font(.custom("Futura", size: 20))
                })
                .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(20)
            }
            .navigationTitle("Nouvelle étape")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addTravel(){
        let newTravel = Travel(context: viewContext)
        newTravel.id = UUID()
        newTravel.date = date
        newTravel.checkin = checkin
        newTravel.checkout = checkout
        newTravel.destinationTown = destinationTown
        newTravel.flight = flight
        newTravel.hotel = hotel
        newTravel.note = note
        newTravel.startTown = startTown
        newTravel.time = time
        newTravel.townImageData = image.pngData()
        newTravel.train = train
        newTravel.travelToDestination = selectedDestination
        do{
            try viewContext.save()
        }
        catch{
            print("Error while saving Employee Data \(error.localizedDescription)")
        }
    }
    
}

struct AddTravel_Previews: PreviewProvider {
    static var previews: some View {
        AddTravel()
    }
}
