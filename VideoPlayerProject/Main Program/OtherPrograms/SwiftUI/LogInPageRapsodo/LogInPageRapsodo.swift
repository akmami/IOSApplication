//
//  LogInPageRapsodo.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-14.
//

import SwiftUI

struct LogInPageRapsodo: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var space: Int = 20
    
    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .top, content: {
                VStack(alignment: .center, spacing: 10, content: {
                    Image(uiImage: UIImage(named: "Rapsodo-MLM-Final-1-768x240.png")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width/2, alignment: .center)
                        .padding()
                    Text("Login")
                        .fontWeight(.bold)
                        .font(.title)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer().frame(height: 20, alignment: .center)
                    CustomTextField(input_textfield: $email, text: "Please enter your e-mail", imageSystemName: "person.crop.circle", isSecureField: false)
                    
                    CustomTextField(input_textfield: $password, text: "Password", imageSystemName: "lock.circle", isSecureField: true)

                    Spacer().frame(height: 20, alignment: .center)
                    
                    Button(action: {
                        print("Sign In button tapped!")
                    }) {
                        Text("Sign In")
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 204/255, green: 20/255, blue: 44/255))
                            .cornerRadius(40)
                    }
                    
                    HStack {
                        Button(action: {
                            print("Forgot Password button tapped!")
                        }) {
                            Text("Forgot Password?")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.mode.wrappedValue.dismiss()
                        }) {
                            Text("Go Back")
                                .foregroundColor(.blue)
                        }
                    }
                })
                .padding(.leading, 20)
                .padding(.trailing, 20)
            })
            .padding()
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

struct LogInPageRapsodo_Previews: PreviewProvider {
    static var previews: some View {
        LogInPageRapsodo()
    }
}
