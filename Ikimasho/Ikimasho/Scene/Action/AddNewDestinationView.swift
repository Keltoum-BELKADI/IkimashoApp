//
//  AddNewDestinationView.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 27/07/2023.
//

import SwiftUI

struct AddNewDestinationView: View {
    @State  var image = UIImage()
    @State  var name: String = ""

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State var imagePicker = false
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
                    TextFieldView(field: $name, value: "Pays", type: .emailAddress)
                }

                Button(action: {
                    saveDestination()
                    dismiss()
                }, label: {
                    Text("Valider")
                        .frame(minWidth:0, maxWidth: .infinity)
                })
                .frame(width: 300, height: 50, alignment: .center)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(20)
            }
        }
    }
    private func saveDestination(){
        let newDestination = Destination(context: viewContext)
        newDestination.id = UUID()
        newDestination.name = name
        newDestination.image = image.pngData()

        do{
            try viewContext.save()
        }
        catch{
            print("Error saving Depart value \(error.localizedDescription)")
        }
    }
}

struct AddNewDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewDestinationView()
    }
}
