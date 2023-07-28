//
//  AddNewTravelView.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 27/07/2023.
//

import SwiftUI


struct AddNewTravelView: View {
    @State private var day: String = ""
    @State private var destinationTown: String = ""
    @State private var flight: String = ""
    @State private var image: UIImage = UIImage()
    @State private var hotel: String = ""
    @State private var note: String = ""
    @State private var time: String = ""
    @State private var town: String = ""
    @State private var train: String = ""
    @State private var date: String = ""
    @State private var checkin: String = ""
    @State private var checkout: String = ""
    @State private var selectedDestination = Destination()

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State var imagePicker = false
    @State var showAlert = false
    var width: CGFloat = 125

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

                Section("N° du jour de voyage:") {
                    TextFieldView(field: $day, value: "N° du jour de voyage", type: .twitter)
                }
                Section("Destination") {
                    TextFieldView(field: $date, value: "Date du départ", type: .emailAddress)
                    TextFieldView(field: $town, value: "Ville de départ", type: .emailAddress)
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
            .navigationTitle("Nouveau voyage")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func addTravel(){
        let newTravel = Travel(context: viewContext)
        newTravel.id = UUID()
        newTravel.day = day
        newTravel.destinationTown = destinationTown
        newTravel.flight = flight
        newTravel.imageData = image.pngData()
        newTravel.hotel = hotel
        newTravel.note = note
        newTravel.time = time
        newTravel.town = town
        newTravel.train = train
        newTravel.date = date
        newTravel.checkin = checkin
        newTravel.checkout = checkout
        newTravel.country  = selectedDestination
        do{
            try viewContext.save()
        }
        catch{
            print("Error while saving Employee Data \(error.localizedDescription)")
        }
    }
}

struct AddNewTravelView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTravelView()
    }
}
