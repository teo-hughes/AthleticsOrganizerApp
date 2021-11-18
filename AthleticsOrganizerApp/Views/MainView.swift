//
//  MainView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//


// Importing SwiftUI
import SwiftUI
import Foundation


// This view will be where you can choose a tournament etc.
struct MainView: View {
    
    
    @State private var presentAddNewTournamentScreen = false
    
    @StateObject var viewModel = TournamentsViewModel()
    
    

    
    
    // The body of the MainView
    var body: some View {
        
        
        
        NavigationView {
            VStack {
                List{
                    

                    ForEach(0..<viewModel.tournaments.count, id: \.self) { n in
                        NavigationLink(destination: TournamentView(tournament: viewModel.tournaments[n], viewModel: viewModel), label: {
                            TournamentCardView(tournament: viewModel.tournaments[n])
                        })
                    }
                }
                /*.refreshable {
                    //viewModel.names = []
                    self.viewModel.fetchTournamentNames()
                    for name in viewModel.names {
                        self.viewModel.fetchData(tournamentCollectionName: name)
                    }
                }*/
                

                Spacer()
                Text("Create Tournament")
                Button( action: { presentAddNewTournamentScreen.toggle() }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                })
                
                //Spacer()
                
            
            }
            .navigationBarTitle("Tournaments")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button( action: {
                        self.viewModel.fetchTournamentNames()
                        for name in viewModel.names {
                            self.viewModel.fetchData(tournamentCollectionName: name)
                        }
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 25))
                    })
                }
            }
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            //viewModel.names = []
            self.viewModel.fetchTournamentNames()
            for name in viewModel.names {
                self.viewModel.fetchData(tournamentCollectionName: name)
            }
            
        })
        .sheet(isPresented: $presentAddNewTournamentScreen) {
            CreateTournamentView()
        }
    }
}

