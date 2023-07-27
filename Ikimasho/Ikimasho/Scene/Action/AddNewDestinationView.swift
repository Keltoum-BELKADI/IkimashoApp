//
//  AddNewDestinationView.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 27/07/2023.
//

import SwiftUI

struct AddNewDestinationView: View {
    @Binding  var flag: String
    @Binding  var name: String

    @Environment(\.presentationMode) var pres

    var body: some View {
        NavigationView {
            List {
                Section("Drapeau") {
                    TextFieldView(field: $flag, value: "Drapeau", type: .twitter)
                }
                Section("Destionation") {
                    TextFieldView(field: $name, value: "Pays", type: .emailAddress)
                }

                Button {
                    self.pres.wrappedValue.dismiss()
                }label: {
                    Text("Valider").frame(alignment: .center)
                        .font(.custom("Futura", size: 20))
                }
                .frame(width: 300, height: 50, alignment: .center)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(20)
            }
        }
    }
}

struct AddNewDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewDestinationView(flag: .constant(""), name: .constant(""))
    }
}
