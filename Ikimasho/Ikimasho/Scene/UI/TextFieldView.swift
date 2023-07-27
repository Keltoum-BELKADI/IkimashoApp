//
//  TextFieldView.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 27/07/2023.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var field: String
    var value: String
    var type: UIKeyboardType

    var body: some View {
        TextField(value, text: $field)
            .keyboardType(type)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(field: .constant(""), value: "Mail", type: .emailAddress)
    }
}
