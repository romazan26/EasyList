//
//  ContentView.swift
//  EasyList
//
//  Created by Роман on 12.01.2025.
//

import SwiftUI

struct LoadingView: View {
    @StateObject var vm = LoadingViewModel()
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            VStack {
                Image(.logo)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
            }
            .padding()
        }
        .fullScreenCover(isPresented: $vm.isPresentMain) {
            RootView()
        }
        .fullScreenCover(isPresented: $vm.isPresentOnboarding) {
            IntroView()
        }
    }
}

#Preview {
    LoadingView()
}
