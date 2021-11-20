//
//  SignInView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 11/11/2021.
//


// Importing SwiftUI
import SwiftUI


// This is the view which allows users to sign in
struct SignInView: View {
    
    
    // Variables to hold the email and password
    @State var email = ""
    @State var password = ""
    
    @State private var presentAlert = false
    
    // Accesses the AuthenticationViewModel
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    
    // The body of the SignInView
    var body: some View {
        
        
        // A VStack allows you to display the image and then the textfields
        VStack {
            
            // Image displayed
            Image("TempLoginImage")
                // UI of image
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            // Seperate VStack for both TextFields
            VStack {
                
                // Text field to input your email
                TextField("Email Address", text: $email)
                    // Disable autocorrect and autocapitalize
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                // SecureField means the password is not visible when typed in
                SecureField("Password", text: $password)
                    // Disable autocorrect and autocapitalize
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                // The button which will sign you in
                Button(action: {
                    
                    // If both textfields aren't empty
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    // Sign in using the viewModel
                    viewModel.signIn(email: email, password: password)
                    
                    // If the viewModel failed to sign up show an Alert
                    if viewModel.signedIn == false && viewModel.signInErrorMessage != "" {
                        presentAlert = true
                    }
                    
                }, label: {
                    
                    // UI of button
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                    
                })
                // Alert shown with error Message
                .alert(isPresented: $presentAlert) {
                    // Error message shown with the error firebase returned
                    Alert(title: Text("Sign In Failed"), message: Text("\(viewModel.signInErrorMessage)"), dismissButton: .default(Text("OK")))
                }
                
                // Seperate button to send you to the SignUpView
                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
            }
            .padding()
            
            // Moves the VStacks to the top
            Spacer()
        }
        .navigationTitle("Sign In")
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
                .contentShape(Rectangle()) ///otherwise swipe won't work in vacant area
                .offset(x: offset)
                .gesture(DragGesture(minimumDistance: 15, coordinateSpace: .local)
                            .onChanged({ (value) in
                                let totalSlide = value.translation.width + oldOffset
                                if  (0...Int(maxLeadingOffset) ~= Int(totalSlide)) || (Int(minTrailingOffset)...0 ~= Int(totalSlide)) { //left to right slide
                                    withAnimation{
                                        offset = totalSlide
                                    }
                                }
                                ///can update this logic to set single button action with filled single button background if scrolled more then buttons width
                            })
                            .onEnded({ value in
                                withAnimation {
                                    if visibleButton == .left && value.translation.width < -20 { ///user dismisses left buttons
                                        reset()
                                    } else if  visibleButton == .right && value.translation.width > 20 { ///user dismisses right buttons
                                        reset()
                                    } else if offset > 25 || offset < -25 { ///scroller more then 50% show button
                                        if offset > 0 {
                                            visibleButton = .left
                                            offset = maxLeadingOffset
                                        } else {
                                            visibleButton = .right
                                            offset = minTrailingOffset
                                        }
                                        oldOffset = offset
                                        ///Bonus Handling -> set action if user swipe more then x px
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) { ///call once hide animation done
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) { ///call once hide animation done
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


