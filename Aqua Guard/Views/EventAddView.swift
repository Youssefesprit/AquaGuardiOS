//
//  EventAddView.swift
//  Aqua Guard
//
//  Created by Malek Labidi on 29/11/2023.
//

import SwiftUI

struct EventAddView: View {
    @EnvironmentObject var viewModel: MyEventViewModel
    @State private var eventName = ""
       @State private var eventDescription = ""
    @State private var startDate = Date()
     @State private var endDate = Date()
       @State private var eventLocation = ""
       @State private var errorMessage = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var isDatePickerPresented = false
    
    @State private var showAlert = false
     @State private var alertMessage = ""
    var body: some View {
        NavigationView {
            ZStack {
               
                
                VStack {
                  Spacer()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.darkBlue)
                            
                            Button(action: {
                                // Action for updating event image
                                print("Add Event Image")
                            }) {
                                Label("Add Event image", systemImage: "photo.on.rectangle")
                                    .foregroundColor(.darkBlue)
                            }
                            
                            TextField("Event Name", text: $eventName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.top, 10)
                            
                            TextField("Event Description", text: $eventDescription)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.top, 10)
                            
                            VStack {
                                        TextField("Start Date", text: Binding(
                                            get: {
                                                // Convert the Date to String with the desired format
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                                return dateFormatter.string(from: startDate)
                                            },
                                            set: { newDateString in
                                                // Convert the String to Date with the desired format
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                                if let newDate = dateFormatter.date(from: newDateString) {
                                                    startDate = newDate
                                                }
                                            }
                                        ))
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding(.top, 10)

                                        Button(action: {
                                            // Show the DatePicker with confirmation
                                            isDatePickerPresented.toggle()
                                        }) {
                                            Text("Select Start Date")
                                        }
                                        .padding()

                                        // Present the DatePicker in a sheet
                                        if isDatePickerPresented {
                                            DatePickerSheet(selectedDate: $startDate, isPresented: $isDatePickerPresented)
                                        }
                                    }
                            VStack {
                                        TextField("End Date", text: Binding(
                                            get: {
                                                // Convert the Date to String with the desired format
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                                return dateFormatter.string(from: endDate)
                                            },
                                            set: { newDateString in
                                                // Convert the String to Date with the desired format
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                                if let newDate = dateFormatter.date(from: newDateString) {
                                                    endDate = newDate
                                                }
                                            }
                                        ))
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding(.top, 10)

                                        Button(action: {
                                            // Show the DatePicker with confirmation
                                            isDatePickerPresented.toggle()
                                        }) {
                                            Text("Select End Date")
                                        }
                                        .padding()

                                        // Present the DatePicker in a sheet
                                        if isDatePickerPresented {
                                            DatePickerSheet(selectedDate: $endDate, isPresented: $isDatePickerPresented)
                                        }
                                    }
                            TextField("Event Location", text: $eventLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.top, 10)
                            
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(.top, 10)
                                .hidden() // You may need to handle the visibility based on your logic.
                            
                            Button(action: {
                                // Action for submitting event
                                print("Submit Event")
                                viewModel.createEvent(userName: "String", userImage: "String", eventName: eventName, description: eventDescription, eventImage: "sidi_bou_said", dateDebut: startDate, dateFin: endDate, lieu: eventLocation)
                                // Show alert
                                            alertMessage = "Event added successfully"
                                            showAlert = true
                              
                            }) {
                                Text("Submit")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }   .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Success"),
                                    message: Text(alertMessage),
                                    dismissButton: .default(Text("OK")) {
                                        // Dismiss the current view
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                )
                            }
                            .padding(.top, 20)
                        }
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding([.leading, .trailing], 10)
                    }
                    .navigationBarTitle("Add Event", displayMode: .inline)
                }
                .background(Image("background_splash_screen")
                                         .resizable()
                                         .scaledToFill()
                                         .edgesIgnoringSafeArea(.all))
            }
        }
    }
}

#Preview {
    EventAddView()
}
