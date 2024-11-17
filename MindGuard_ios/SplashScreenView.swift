//
//  SplashScreenView.swift
//  MindGuard_ios
//
//  Created by Chitrap Srivastava on 07/11/24.
//


import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    var body: some View {
        ZStack {
            // Background color
            Image("HOME") // Use the name of the image in your assets
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                

            VStack {
                Spacer()
                
                Spacer()
                
                // Creator names
                VStack {
                    Text("Created by:")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text("Srijan Raj\nChitrap Srivastava")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
        .ignoresSafeArea() // Make it full screen
        .onAppear {
            // Start a 3-second timer
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
