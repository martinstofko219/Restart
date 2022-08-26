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
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Home").font(.largeTitle)
            
            Button {
                showingOnboardingView = true
            } label: {
                Text("Restart")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
