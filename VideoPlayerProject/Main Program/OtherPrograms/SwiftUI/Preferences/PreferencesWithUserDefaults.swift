//
//  PreferencesWithUserDefaults.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-26.
//

import SwiftUI
import Combine

struct PreferencesWithUserDefaults: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var userSettings = UserSettings()
    
    private var gender: Gender = .notSpecified
    var maleBtnBackgroundColor: Color {
        if self.userSettings.gender == Gender.female.rawValue || self.userSettings.gender == Gender.notSpecified.rawValue {
            return Color.white
        } else {
            return Color.green
        }
    }
    var femaleBtnBackgroundColor: Color {
        if self.userSettings.gender == Gender.male.rawValue || self.userSettings.gender == Gender.notSpecified.rawValue  {
            return Color.white
        } else {
            return Color.green
        }
    }
    
    var ages = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]
    
    @State private var isShowingPicker = false
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView{
                    ZStack(alignment: .top, content: {
                        VStack(alignment: .center, spacing: 15, content: {
                            
                            Text("User Defaults")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                
                            Group {
                                HStack(spacing: 10, content: {
                                    Text("Name")
                                        .frame(width: 100, alignment: .trailing)
                                    
                                    TextField("Please enter name", text: $userSettings.name)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.systemGray3), lineWidth: 1)
                                        )
                                })
                                
                                HStack(spacing: 10, content: {
                                    Text("Surname")
                                        .frame(width: 100, alignment: .trailing)
                                        
                                    TextField("Please enter Surname", text: $userSettings.surname)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.systemGray3), lineWidth: 1)
                                        )
                                })
                                
                                HStack(spacing: 10, content: {
                                    Text("E-mail")
                                        .frame(width: 100, alignment: .trailing)
                                        
                                    
                                    TextField("Please enter email", text: $userSettings.email)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.systemGray3), lineWidth: 1)
                                        )
                                    
                                })
                                
                                HStack(spacing: 10, content: {
                                    Text("Password")
                                        .frame(width: 100, alignment: .trailing)
                                    
                                    TextField("Please enter password", text: $userSettings.password)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.systemGray3), lineWidth: 1)
                                        )
                                })
                                
                                HStack(spacing: 10, content: {
                                    Text("Number")
                                        .frame(width: 100, alignment: .trailing)
                                    
                                    TextField("Please enter number", text: $userSettings.number)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.systemGray3), lineWidth: 1)
                                        )
                                })
                                
                                HStack(spacing: 10, content: {
                                    Text("Age")
                                        .frame(width: 100, alignment: .trailing)
                                    
                                    TextField("Please enter age", text: $userSettings.age)
                                        .keyboardType(.numberPad)
                                        .disableAutocorrection(true)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.systemGray3), lineWidth: 1)
                                        )
    //                                Button(action: {
    //                                    self.isShowingPicker.toggle()
    //                                }) {
    //                                    Text("\(self.age)")
    //                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    //                                        .background(Color.green)
    //                                }
                                })
                            }
                                
                            Group {
                                HStack(spacing: 10, content: {
                                    Text("Gender")
                                        .frame(width: 100, alignment: .trailing)
                                    
//                                    TextField("Please enter gender", text: $userSettings.gender)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 5)
//                                                .stroke(Color(.systemGray3), lineWidth: 1)
//                                        )
                                    
                                    Button("Male", action: {
                                        if self.userSettings.gender != Gender.male.rawValue {
                                            self.userSettings.gender = Gender.male.rawValue
                                        } else {
                                            self.userSettings.gender = Gender.notSpecified.rawValue
                                        }
                                        
                                    })
                                    .background(maleBtnBackgroundColor)
                                    
                                    Button("Female", action: {
                                        if self.userSettings.gender != Gender.female.rawValue {
                                            self.userSettings.gender = Gender.female.rawValue
                                        } else {
                                            self.userSettings.gender = Gender.notSpecified.rawValue
                                        }
                                    })
                                    .background(femaleBtnBackgroundColor)
                                    
                                    Spacer()
                                })
                                
                                HStack(spacing: 10, content: {
                                    Text("Weight")
                                        .frame(width: 100, alignment: .trailing)
                                    
                                    TextField("Please enter weight", text: $userSettings.weight)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.systemGray3), lineWidth: 1)
                                        )
                                })
                                
                                HStack(spacing: 10, content: {
                                    Text("Hobbies")
                                        .frame(width: 100, alignment: .trailing)
                                    
                                    TextField("Please enter hobby", text: $userSettings.hobbies)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.systemGray3), lineWidth: 1)
                                        )
                                })
                            }
                            
                            Group {
                                HStack(spacing: 10, content: {
                                    Text("Heighest Scores")
                                        .frame(width: 100, alignment: .trailing)
                                        .multilineTextAlignment(.trailing)
                                    
                                    TextField("Please enter heighest score", text: $userSettings.heighest_scores)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.systemGray3), lineWidth: 1)
                                        )
                                })
                            }
                            
                            Button(action: {
                                self.mode.wrappedValue.dismiss()
                            }) {
                                Text("Go Back")
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            
 
                        })
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    })
                    .padding()
                    
//                    NumberPicker(selection: $age, isShowing: self.$isShowingPicker)
//                                    .animation(.linear)
//                                    .offset(y: self.isShowingPicker ? 0 : UIScreen.main.bounds.height)
                       
                    
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
            
        }
    }
}

struct PreferencesWithUserDefaults_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesWithUserDefaults()
    }
}
