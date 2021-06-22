//
//  EntryField.swift
//  Combine Form Validation Starter
//
//  Created by Stewart Lynch on 2021-06-20.
//

import SwiftUI

struct EntryField: View {
    var sfSymbolName: String
    var placeholder: String
    var prompt: String
    @Binding var field: String
    var isSecure = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                    .frame(width: 20)
                if isSecure {
                    SecureField(placeholder, text: $field)
                } else {
                    TextField(placeholder, text: $field)
                }
            }.autocapitalization(.none)
            .padding(8)
            .background(Color(.secondarySystemBackground))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
    }
}

struct EntryField_Previews: PreviewProvider {
    static var previews: some View {
        EntryField(sfSymbolName: "envelope", placeholder: "Email Address", prompt: "Enter a valid email address", field: .constant(""))
    }
}
