//
//  AddTimesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 25/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct AddTimesView: View {
    
    @State var event: Event
    @State var event_times: [Double] = []
    
    @Environment(\.presentationMode) var presentationMode
    
    // The body of the InfoView
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add Times")) {
                    List {
                        ForEach(0..<event.Athletes.count, id: \.self) { n in
                            Text(event.Athletes[n].name)
                            /*TextField("\(event.Athletes[n].name) time: ", text: $event_times[n])*/
                        }
                    }
                }
            }
            /*.onAppear {
                for 0..<event.Athletes.count {
                    event_times.append(0.00)
                }
            }*/
            .navigationBarItems(
                leading: Button(action: {
                    handleCancelTapped()
                }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {
                    handleDoneTapped()
                }, label: {
                    Text("Done")
                })
            )
        }
        
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}
