//
//  MainView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//


// Importing SwiftUI
import SwiftUI
import Foundation


let buttonWidth: CGFloat = 60

enum CardButtons: Identifiable {
    
    case edit
    case delete
    
    var id: String {
        return "\(self)"
    }
}

struct CardButtonView: View {
    
    let data: CardButtons
    let cardHeight: CGFloat
    
    func getView(for image: String, title: String) -> some View {
        
        VStack {
            Image(systemName: image)
            Text(title)
        }
        .padding(5)
        .foregroundColor(.primary)
        .font(.subheadline)
        .frame(width: buttonWidth, height: cardHeight)
    }
    
    var body: some View {
        switch data {
        case .edit:
            getView(for: "pencil.circle", title: "Edit")
                .background(Color.pink)
        case .delete:
            getView(for: "delete.right", title: "Delete")
                .background(Color.red)
        }
    }
    
}

// This view will display the tournaments
struct MainView: View {
    
    
    // To show the sheet to add a new tournamnet
    @State private var presentAddNewTournamentScreen = false
    
    // Connect to the tournaments view model to fetch data from firestore
    @StateObject var viewModel = TournamentsViewModel()
    
    
    // The body of the MainView
    var body: some View {
        
        // NavigationView so the user can navigate to and from a tournament
        NavigationView {
            
            // VStack to show all the tournaments
            VStack {
                List {
                    
                    // For each loop which goes through all the tournaments
                    ForEach(0..<viewModel.tournaments.count, id: \.self) { n in
                        
                        HStack {
                            Spacer()
                            // Display a navigation link which will go to the specific tournamentView
                            NavigationLink(destination: TournamentView(tournament: viewModel.tournaments[n], viewModel: viewModel), label: {
                                
                                // Shown as a tournamentCardView
                                TournamentCardView(tournament: viewModel.tournaments[n])
                                    
                            })
                            Spacer()
                        }
                        .addButtonActions(leadingButtons: [.edit], trailingButton:  [.delete], onClick: { button in
                            print("clicked: \(button)")
                        })
                        
                    }
                }
                
                // Spacer to move the tournaments to the top
                Spacer()
                
                // Button to create a tournament
                Text("Create Tournament")
                
                // When the button is pressed, it toggles presentAddNewTournamentScreen
                Button( action: {
                    presentAddNewTournamentScreen.toggle()
                }, label: {
                    
                    // Shows a +
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                })
            }
            .navigationBarTitle("Tournaments")
            // Refresh button to load the tournaments
            .toolbar {
                
                // Add to the toolbar on the top right
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    // A button which fetches the tournament names and then all the tournaments from firestore
                    Button( action: {
                        self.viewModel.fetchTournamentNames()
                        for name in viewModel.names {
                            self.viewModel.fetchData(tournamentCollectionName: name)
                        }
                    }, label: {
                        
                        // Shows a refresh button
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 25))
                    })
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
        // When it appears fetches the tournament names and then all the tournaments from firestore
        .onAppear(perform: {
            self.viewModel.fetchTournamentNames()
            for name in viewModel.names {
                self.viewModel.fetchData(tournamentCollectionName: name)
            }
        })
        // Shows the CreateTournamentView if the presentAddNewTournamentScreen is true
        .sheet(isPresented: $presentAddNewTournamentScreen) {
            CreateTournamentView()
        }
    }
}




extension View {
    func addButtonActions(leadingButtons: [CardButtons], trailingButton: [CardButtons], onClick: @escaping (CardButtons) -> Void) -> some View {
        self.modifier(SwipeContainerButton(leadingButtons: leadingButtons, trailingButton: trailingButton, onClick: onClick))
    }
}

struct SwipeContainerButton: ViewModifier {
    enum VisibleButton {
        case none
        case left
        case right
    }
    
    @State private var offset: CGFloat = 0
    @State private var oldOffset: CGFloat = 0
    @State private var visibleButton: VisibleButton = .none
    let leadingButtons: [CardButtons]
    let trailingButton: [CardButtons]
    let maxLeadingOffset: CGFloat
    let minTrailingOffset: CGFloat
    let onClick: (CardButtons) -> Void
    
    init(leadingButtons: [CardButtons], trailingButton: [CardButtons], onClick: @escaping (CardButtons) -> Void) {
        self.leadingButtons = leadingButtons
        self.trailingButton = trailingButton
        maxLeadingOffset = CGFloat(leadingButtons.count) * buttonWidth
        minTrailingOffset = CGFloat(trailingButton.count) * buttonWidth * -1
        self.onClick = onClick
    }
    
    func reset() {
        visibleButton = .none
        offset = 0
        oldOffset = 0
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .contentShape(Rectangle())
                .offset(x: offset)
                .gesture(DragGesture(minimumDistance: 15, coordinateSpace: .local)
                            .onChanged({ (value) in
                                let totalSlide = value.translation.width + oldOffset
                                if  (0...Int(maxLeadingOffset) ~= Int(totalSlide)) || (Int(minTrailingOffset)...0 ~= Int(totalSlide)) {
                                    withAnimation{
                                        offset = totalSlide
                                    }
                                }
                            })
                            .onEnded({ value in
                                withAnimation {
                                    if visibleButton == .left && value.translation.width < -20 {
                                        reset()
                                    } else if  visibleButton == .right && value.translation.width > 20 {
                                        reset()
                                    } else if offset > 25 || offset < -25 {
                                        if offset > 0 {
                                            visibleButton = .left
                                            offset = maxLeadingOffset
                                        } else {
                                            visibleButton = .right
                                            offset = minTrailingOffset
                                        }
                                        oldOffset = offset
                                    } else {
                                        reset()
                                    }
                                }
                            }))
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(leadingButtons) { buttonsData in
                            Button(action: {
                                withAnimation {
                                    reset()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                                    onClick(buttonsData)
                                }
                            }, label: {
                                CardButtonView.init(data: buttonsData, cardHeight: proxy.size.height)
                            })
                        }
                    }.offset(x: (-1 * maxLeadingOffset) + offset)
                    Spacer()
                    HStack(spacing: 0) {
                        ForEach(trailingButton) { buttonsData in
                            Button(action: {
                                withAnimation {
                                    reset()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                                    onClick(buttonsData)
                                }
                            }, label: {
                                CardButtonView.init(data: buttonsData, cardHeight: proxy.size.height)
                            })
                        }
                    }.offset(x: (-1 * minTrailingOffset) + offset)
                }
            }
        }
    }
}




