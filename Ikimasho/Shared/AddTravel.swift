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
    @State private var date = Date.now
    @State private var checkin: String = ""
    @State private var checkout: String = ""
    @State private var imagePicker = false
    @State private var selectedDestination = Destination()

    @State private var showAlert = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Destination.name, ascending: true)]) private var destinations:FetchedResults<Destination>
    
    var body: some View {
        NavigationView {
            List {
                Section {
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
                }header: {
                    Text("Image")
                }footer: {
                    Text("Utiliser de préférence des photos enregistrés que prises avec l'outil photo.")
                        .lineLimit(2)
                }

                Section() {
                    VStack {
                        Text("La date du séjour")
                               .font(.largeTitle)
                           DatePicker("choisir la date", selection: $date)
                               .datePickerStyle(GraphicalDatePickerStyle())
                               .frame(maxHeight: 400)
                       }
                    TextFieldView(field: $startTown, value: "Ville de départ", type: .default)
                    TextFieldView(field: $destinationTown, value: "Ville d'arrivée", type: .default)
                    TextFieldView(field: $flight, value: "Vol", type: .default)
                    TextFieldView(field: $train, value: "Shinkansen", type: .default)

                    Picker("Sélectionner une destination:", selection: $selectedDestination){
                        ForEach(destinations,id: \.self){
                            Text($0.name ?? "").tag($0 as Destination?)
                        }
                    }
                }header: {
                    Text("Destination")
                }footer: {
                    Text("Il est important de renseigner la destination ⛔️.")
                        .lineLimit(2)
                        .bold()
                }
                Section("Hébergement") {
                    TextFieldView(field: $hotel, value: "information hotel", type: .default)
                        .frame(height: 125)
                        .lineLimit(100)
                    TextFieldView(field: $time, value: "Durée de l'hébergement", type: .default)
                    TextFieldView(field: $checkin, value: "heure d'arrivée", type: .numbersAndPunctuation)
                    TextFieldView(field: $checkout, value: "heure de départ", type: .numbersAndPunctuation)
                }
                Section {
                    TextEditor(text: $note)
                        .lineLimit(300)
                        .frame(height: 200)
                }header: {
                    Text("Information de voyage et activités")
                }footer: {
                    Text("Il est important de renseigner toutes les informations importantes.")
                        .lineLimit(2)
                        .bold()
                }

                Button(action: {
                    if destinationTown.isEmpty {
                        showAlert = true
                    } else {
                        addTravel()
                        dismiss()
                    }
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
            .alert("Tu n'as pas renseigné la ville d'arrivée.", isPresented: $showAlert) {
                Button("OK") {
                    showAlert = false
                }
            }
        }
    }
    
    private func addTravel(){
        let newTravel = Travel(context: viewContext)
        newTravel.id = UUID()
        newTravel.date = date.formatted()
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
