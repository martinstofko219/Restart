//
//  HomeView.swift
//  Restart
//
//  Created by Martin Stofko on 8/26/22.
//

import SwiftUI

struct HomeView: View {
    // AppStorage onboarding will only initialize if it doesn't find this key/value in AppStorage; otherwise initialization is skipped
    @AppStorage("onboarding") var showingOnboardingView = false
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // MARK: Illustration
            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .repeatForever(),
                        value: isAnimating)
            }
            
            // MARK: TEXT
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            // MARK: Button
            Button {
                withAnimation {
                    AudioPlayer.shared.playSound(sound: "success", type: "m4a")
                    showingOnboardingView = true
                }
            } label: {
                Label {
                    Text("Restart")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                } icon: {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                }
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isAnimating = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
