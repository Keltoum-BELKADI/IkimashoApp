//
//  AddDepartment.swift
//  CD_One_To_Many_Relationship
//
//  Created by Haaris Iqubal on 1/8/22.
//

import SwiftUI

struct AddDestination: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var destinationName = ""
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Entrer votre nouvelle destination",text: $destinationName)
                Button(action: {
                    saveDestination()
                    dismiss()
                }, label: {
                    Text("Valider")
                        .frame(minWidth:0, maxWidth: .infinity)
                        .font(.custom("Futura", size: 20))
                        .bold()
                })
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .tint(.blue)
            }
            .navigationTitle("Ajouter une destination")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func saveDestination(){
        let newDestination = Destination(context: viewContext)
        newDestination.id = UUID()
        newDestination.name = destinationName
        
        do{
            try viewContext.save()
        }
        catch{
            print("Error saving Depart value \(error.localizedDescription)")
        }
    }
}

struct AddDestination_Previews: PreviewProvider {
    static var previews: some View {
        AddDestination()
    }
}
