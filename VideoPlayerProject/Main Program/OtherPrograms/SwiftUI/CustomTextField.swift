//
//  CustomTextField.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-16.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var input_textfield: String
    @State var text: String
    @State var imageSystemName: String
    @State var isSecureField: Bool
    
    var body: some View {
        HStack {
            Image(systemName: imageSystemName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 10))
            if isSecureField {
                SecureField(text, text: $input_textfield)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            } else {
                TextField(text, text: $input_textfield)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }

        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(.systemGray3), lineWidth: 1)
        )
        .background(Color(.systemGray6))
    }
}

