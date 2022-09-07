//
//  OnboardingView.swift
//  Restart
//
//  Created by Martin Stofko on 8/26/22.
//

import SwiftUI

struct OnboardingView: View {
    // AppStorage onboarding will only initialize if it doesn't find this key/value in AppStorage; otherwise initialization is skipped
    @AppStorage("onboarding") var showingOnboardingView = true
    
    @State private var isAnimating = false
    @State private var buttonOffset: CGFloat = 0
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle = "Share."
    
    private let buttonWidth = UIScreen.main.bounds.width - 80
    private let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("BrandBlue").ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                // MARK: Top Text
                VStack {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("It's not how much we give but\nhow much love we put into giving.")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                Spacer()
                
                // MARK: Illustration
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1.25), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.75), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    // using absolute so we don't have to worry about negative translation
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25).delay(0.5)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                })
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }
                .overlay(alignment: .bottom) {
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(1.5), value: isAnimating)
                        .opacity(indicatorOpacity)
                }
                
                // MARK: Custom Slide Button
                ZStack {
                    // base
                    Capsule().fill(Color.white.opacity(0.2))
                    Capsule().fill(Color.white.opacity(0.2)).padding(8)
                    
                    // text
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // circle button dynamic background
                    HStack {
                        Capsule().fill(Color("BrandRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    
                    // draggable circle button
                    HStack {
                        ZStack {
                            Circle().fill(Color("BrandRed"))
                            Circle().fill(.black.opacity(0.15)).padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                })
                                .onEnded({ _ in
                                    withAnimation(Animation.easeOut(duration: 0.5)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            AudioPlayer.shared.playSound(sound: "chimeup", type: "mp3")
                                            hapticFeedback.notificationOccurred(.success)
                                            buttonOffset = buttonWidth - 80
                                            showingOnboardingView = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                })
                        )
                        
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: 80)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }
        }
        .onAppear { isAnimating = true }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
