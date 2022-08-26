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
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Onboarding").font(.largeTitle)
            
            Button {
                showingOnboardingView = false
            } label: {
                Text("Start")
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
