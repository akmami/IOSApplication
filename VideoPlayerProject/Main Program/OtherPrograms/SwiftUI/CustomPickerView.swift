//
//  CustomPickerView.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-22.
//

import SwiftUI

struct CustomPickerView: View {
    
    var items: [String]
    @State private var frameHeight: CGFloat = 370
    @Binding var pickerField: String
    @Binding var presentPicker: Bool
    var saveUpdates: ((String) -> Void)?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
            
            VStack(spacing: 0){
                HStack {
                    Text("Please select your country.")
                        .padding()
                        .font(.title3)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .frame(height: 50)
                 
                VStack(alignment: .leading, spacing: 5) {
                    List {
                        ForEach(items, id: \.self) { item in
                            Button(item, action: {
                                if item != "None" {
                                    pickerField = item
                                }
                                presentPicker = false
                            })
                        }
                    }
                    .onAppear {
                        if items.count < 6 {
                            UITableView.appearance().isScrollEnabled = false
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            presentPicker = false
                        }
                    }) {
                        Text("Cancel")
                            .padding()
                            .foregroundColor(.black)
                    }
                }
                .frame(height: 50)
            }
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .frame(maxWidth: 400)
            .padding(.horizontal,10)
            .frame(height: frameHeight)
        }
        .onAppear {
            setHeight()
        }
    }
    
    fileprivate func setHeight() {
        withAnimation {
            if items.count == 0 {
               presentPicker = false
            } else if items.count > 5 {
                frameHeight = 365
            } else  {
                frameHeight = CGFloat(items.count * 45 + 100)
            }
        }
    }
    
}

struct CustomPickerView_Previews: PreviewProvider {
    static let sampleData = ["Milk", "Apples", "Sugar", "Eggs", "Oranges", "Potatoes", "Corn", "Bread"].sorted()
    static var previews: some View {
        CustomPickerView(items: sampleData, pickerField: .constant(""), presentPicker: .constant(true))
    }
}
