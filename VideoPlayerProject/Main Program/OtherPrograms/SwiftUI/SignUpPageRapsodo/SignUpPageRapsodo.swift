//
//  SignUpPageRapsodo.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-16.
//

import SwiftUI

struct SignUpPageRapsodo: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var full_name: String = ""
    @State var email: String = ""
    @State var country: String = ""
    @State var password1: String = ""
    @State var password2: String = ""
    @State var presentPicker = false    // for country
    
    @State private var countries = ["None", "United States", "Canada", "Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and/or Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Cook Islands", "Costa Rica", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecudaor", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France, Metropolitan", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Ivory Coast", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kosovo", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfork Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia South Sandwich Islands", "South Sudan", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbarn and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States minor outlying islands", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City State", "Venezuela", "Vietnam", "Virigan Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zaire", "Zambia", "Zimbabwe"]
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
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
                            CustomTextField(input_textfield: $full_name, text: "Please enter your full name", imageSystemName: "person.crop.circle", isSecureField: false)
                            CustomTextField(input_textfield: $email, text: "Please enter your e-mail", imageSystemName: "envelope", isSecureField: false)
                            CustomPickerTextView(input_textfield: $country, text: "Please enter country", imageSystemName: "flag", presentPicker: $presentPicker)
                            CustomTextField(input_textfield: $password1, text: "Please enter password", imageSystemName: "lock.circle", isSecureField: true)
                            CustomTextField(input_textfield: $password2, text: "Validate your password", imageSystemName: "lock.circle", isSecureField: true)
                            Spacer().frame(height: 20, alignment: .center)
                            
                            Group {
                                Button(action: {
                                    print("Sign Up button tapped!")
                                    self.mode.wrappedValue.dismiss()
                                }) {
                                    Text("Sign Up")
                                        .fontWeight(.bold)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color(red: 204/255, green: 20/255, blue: 44/255))
                                        .cornerRadius(40)
                                }
                                
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        self.mode.wrappedValue.dismiss()
                                    }) {
                                        Text("Go Back")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        })
                        .padding(.leading, 20)
                        .padding(.trailing, 20) // End of VStack
                    }) // End of ZStack
                } // End of ZStack ScrollView
                .navigationBarTitle("")
                .navigationBarHidden(true)
            } // End of ZStack NavigationView
            if presentPicker {
                CustomPickerView(items: countries, pickerField: $country, presentPicker: $presentPicker, saveUpdates: nil)
            }
        } // End of ZStack
        
    }
    
}
struct SignUpPageRapsodo_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPageRapsodo()
    }
}

