//
//  MainAppView.swift
//  Restart
//
//  Created by Martin Stofko on 8/24/22.
//

import SwiftUI

struct MainAppView: View {
    @AppStorage("onboarding") var showingOnboardingView = true
    
    var body: some View {
        ZStack {
            if showingOnboardingView {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
