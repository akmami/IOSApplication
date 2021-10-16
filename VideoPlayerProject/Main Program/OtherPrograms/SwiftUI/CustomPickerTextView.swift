//
//  CustomPickerTextView.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-22.
//

import SwiftUI

struct CustomPickerTextView: View {
    
    @Binding var input_textfield: String
    @State var text: String
    @State var imageSystemName: String
    @Binding var presentPicker: Bool
    
    var body: some View {
        HStack {
            Image(systemName: imageSystemName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 10))
            
            TextField(text, text: $input_textfield).disabled(true)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .overlay(
                    Button(action: {
                        withAnimation {
                            presentPicker = true
                        }
                    }) {
                        Rectangle().foregroundColor((Color.clear))
                    }
                )
            if input_textfield != "" {
                Button(action: {
                    input_textfield = ""
                }) {
                    Image(systemName: "delete.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding()
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(.systemGray3), lineWidth: 1)
        )
        .background(Color(.systemGray6))
    }
}

