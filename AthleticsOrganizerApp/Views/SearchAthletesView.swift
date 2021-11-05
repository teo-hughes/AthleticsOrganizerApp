//
//  SearchAthletesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 26/10/2021.
//

//
//  AddTimesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 25/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct SearchAthletesView: View {
    
    @State var event: Event
    @State var tournamentAthletes: [Athlete]
    @State var chosenAgeGroup: String
    @State var chosenGender: String
    @State var tournamentName: String
    
    
    @StateObject var viewModel = EventViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var AthleteNames: [String] = []
    @State var AthletesChecked: [Bool] = []
    @State var AthleteIndexes: [Int] = []
    
    
    @State var searchingFor = ""
    
    // The body of the InfoView
    var body: some View {

        NavigationView {
            List {
                ForEach(0..<results.count, id: \.self) { n in
                    
                    let index: Int = AthleteNames.firstIndex(of: results[n])!
                    HStack {
                        Text(results[n])
                        Spacer()
                        ZStack {
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            if AthletesChecked[index] {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.green)
                            }
                        }
                        
                        
                    }
                    .padding()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        AthletesChecked[index].toggle()
                    }
                }
            }
            /*.searchable(text: $searchingFor, placement: SearchFieldPlacement.automatic, prompt: "Searching athletes...")*/
            .navigationTitle("Add Athletes")
            
            .navigationBarItems(
                leading: Button(action: {
                    handleCancelTapped()
                }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {
                    
                    for n in 0..<AthletesChecked.count {
                        if AthletesChecked[n] {
                            event.Athletes.append(tournamentAthletes[AthleteIndexes[n]])
                        }
                    }
                    handleDoneTapped()
                }, label: {
                    Text("Done")
                })
            )
        }
        .onAppear(perform: {
            for n in 0..<tournamentAthletes.count {
                if tournamentAthletes[n].age_group == chosenAgeGroup && tournamentAthletes[n].gender == chosenGender {
                    AthleteNames.append(tournamentAthletes[n].name)
                    AthletesChecked.append(false)
                    AthleteIndexes.append(n)
                }
            }
        })
    }
    
    var results: [String] {
        if searchingFor.isEmpty {
            return AthleteNames
        } else {
            return AthleteNames.filter { $0.contains(searchingFor)}
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        viewModel.saveEvent(tournamentName: tournamentName, event: event)
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
