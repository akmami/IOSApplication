//
//  NumberPicker.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-29.
//

import Foundation
import SwiftUI

struct NumberPicker: View {
    @Binding var selection: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Button(action: {
                self.isShowing = false
            }) {
                HStack {
                    Text("Close")
                }
            }
            
            Picker(selection: $selection, label: Text("")) {
                ForEach((1..<100), id: \.self) { number in
                    Text("\(number)")
                        .tag(number)
                }
            }
            .frame(width: 200)
            .labelsHidden()
        })
    }
}
