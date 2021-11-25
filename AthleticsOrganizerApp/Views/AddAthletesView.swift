//
//  AddAthletesView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 23/10/2021.
//


// Importing SwiftUI
import SwiftUI


// This view will allow users to add athletes/teams to a tournament
struct AddAthletesView: View {
    
    
    // Fetch the tournamentName, event, athletes and viewModel as parameters
    @State var tournamentName: String
    @State var tournament: Tournament
    @State var events: [Event]
    @State var athletes: [Athlete]
    @StateObject var viewModel = AthleteViewModel()
    @StateObject var tournamentViewModel = TournamentViewModel()
    
    // Variable which is the mode of the sheet (allows us to dismiss it)
    @Environment(\.presentationMode) var presentationMode
    
    // Variables which will hold some of the data of the teams
    @State private var ChosenTeam: String = ""
    @State private var teamExpand = false
    
    // Variables which will hold some of the data of the athletes
    @State private var AthleteTeam: String = ""
    @State private var AthleteName: String = ""
    @State private var AthleteMale = true
    @State private var AthleteFemale = false
    @State private var AthleteGender: String = "Male"
    @State private var AthleteAgeGroup: String = ""
    
    @State private var presentAlert = false
    
    // The body of AddAthletesView
    var body: some View {
        
        // NavigationView allows us to have a navigation bar
        NavigationView {
            
            // Form to structure the view
            Form {
                
                
                // Section for the teams
                Section(header: Text("Teams (Do This First!)")) {
                    
                    // HStack to add teams to the tournament
                    HStack {
                        
                        // Textfield for a team
                        TextField("Add Teams", text: $ChosenTeam)
                        
                        // Button to submit the team
                        Button(action: {
                            
                            // If the team isn't empty add it to the list
                            if ChosenTeam != "" {
                                
                                tournament.teams.append(ChosenTeam)
                                //viewModel.teams.append(ChosenTeam)
                                ChosenTeam = ""
                                //viewModel.addTeam(tournamentName: tournamentName)
                            }
                        }, label: {
                            
                            // UI of button
                            Text("Done")
                        })
                    }
                    
                    // HStack to show the teams
                    HStack {
                        
                        // UI of button to show teams
                        Text("Chosen Teams")
                        Spacer()
                        Image(systemName:  teamExpand ? "chevron.up" : "chevron.down")
                        
                        // When tapped toggle teamExpand
                    }.onTapGesture {
                        self.teamExpand.toggle()
                    }
                    
                    // If teamExpand is true show the teams
                    if teamExpand {
                        
                        // List to show the teams
                        List {
                            
                            // UI of each team
                            ForEach(tournament.teams, id: \.self) { team in
                                Text(team)
                            }
                        }
                    }
                }
                
                
                // Section to add athletes to the tournament
                Section(header: Text("Athletes")) {
                    
                    // Picker to pick a team for the athlete
                    Picker("Choose a Team", selection: $AthleteTeam) {
                        
                        // Shows all the teams
                        ForEach(tournament.teams, id: \.self) { team in
                            Text(team)
                        }
                    }
                    
                    // Picker to pick an age group for the athlete
                    Picker("Choose an AgeGroup", selection: $AthleteAgeGroup) {
                        
                        // Shows all the age groups
                        ForEach(events[0].age_groups, id: \.self) { ageGroup in
                            Text(ageGroup)
                        }
                    }
                    
                    // HStack to pick genders
                    HStack {
                        
                        // UI of HStack
                        Text("Gender")
                        Spacer()
                        Text("Male:")
                        
                        // Checkmark for male in ZStack so I can overlap images
                        ZStack {
                            
                            // Unchecked image shown if AthleteMale is false
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            // If AthleteMale is true
                            if AthleteMale {
                                
                                // Overlap unchecked image with checked image
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.blue)
                            }
                        }
                        // When tapped toggle AthleteMale and AthleteFemale and set AthleteGender to male
                        .onTapGesture {
                            self.AthleteMale.toggle()
                            self.AthleteFemale.toggle()
                            AthleteGender = "Male"
                        }
                        
                        // UI of female
                        Spacer()
                        Text("Female:")
                        
                        // Checkmark for female in ZStack so I can overlap images
                        ZStack {
                            
                            // Unchecked image shown if AthleteFemale is false
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            // If AthleteFemale is true
                            if AthleteFemale {
                                
                                // Overlap unchecked image with checked image
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.red)
                            }
                        }
                        // When tapped toggle AthleteFemale and AthleteMale and set AthleteGender to female
                        .onTapGesture {
                            self.AthleteFemale.toggle()
                            self.AthleteMale.toggle()
                            AthleteGender = "Female"
                        }
                    }
                    
                    
                    // Textfield for the athlete's name
                    TextField("Athlete's Name", text: $AthleteName)
                    
                    // Button to submit the athlete
                    Button(action: {
                        
                        // Save the athlete to the athleteViewModel
                        tournament.Athletes.append(Athlete(name: AthleteName, age_group: AthleteAgeGroup, gender: AthleteGender, team: AthleteTeam))
                        print(tournament.Athletes)
                        // Add the athlete to the ChosenAthletes list

                        
                        // Reset the athleteName
                        AthleteName = ""
                    }, label: {
                        
                        // UI of button
                        Text("Add Athlete")
                    })
                }
                
                Section(header: Text("Teams Already Added")) {
                        
                    List {
                        ForEach(0..<tournament.teams.count, id: \.self) { n in
                            TeamsAlreadyAddedView(tournament: tournament, name: tournament.teams[n], viewModel: viewModel, presentationMode: presentationMode)
                            
                            
                        }
                    
                    }
                }
                
                
                // Section to show the athletes already added
                Section(header: Text("Athletes Already Added")) {
                    
                    // List to go through the athletes
                    List {
                        
                        ForEach(0..<tournament.Athletes.count, id: \.self) { n in
                            
                            let name = tournament.Athletes[n].name
                            
                            HStack {
                                Text(name)
                                    .padding()
                                Text(tournament.Athletes[n].team)
                                    .padding()
                                Spacer()
                                Button(action: {
                                    
                                    tournament.Athletes.remove(at: n)
                                    
                                    
                                    
                                    
                                }, label: {
                                    Text("Delete")
                                })
                            }
                        }
                        
                        
                    }
                }
            }
            .onAppear {
                //viewModel.athletes = athletes
                //viewModel.teams = tournament.teams
            }
            // UI of navigation bar
            .navigationBarTitle("Add Teams", displayMode: .inline)
            .navigationBarItems(
                
                // Leading button to cancel
                leading: Button(action: {
                    
                    // Dismiss the view without saving
                    handleCancelTapped()
                }, label: {
                    
                    // UI of button
                    Text("Cancel")
                }),
                
                // Trailing button to save
                trailing: Button(action: {
                    
                    for team in viewModel.teams {
                        if tournament.teams.contains(team) == false {
                            tournament.teams.append(team)
                        }
                    }
                    tournamentViewModel.addDetails(tournament: tournament)
                    
                    viewModel.athletes = tournament.Athletes
                    viewModel.save(tournamentName: tournamentName)
                    
                    // Dismiss the view with saving
                    handleDoneTapped()
                }, label: {
                    
                    // UI of button
                    Text("Done")
                })
            )
        }
    }
    
    // Function to dismiss when cancelled
    func handleCancelTapped() {
        dismiss()
    }
    
    // Function to save and dismiss when done is pressed
    func handleDoneTapped() {
        
        // Save the athlete to firestore
        viewModel.save(tournamentName: tournamentName)
        dismiss()
    }
    
    // Function which dismisses the view
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
