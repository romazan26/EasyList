//
//  LoadingViewModel.swift
//  EasyList
//
//  Created by Роман on 12.01.2025.
//

import SwiftUI

final class LoadingViewModel: ObservableObject {
    
    @AppStorage("isFirstStart") var isFirstStart: Bool?
    
    @Published var isPresentMain = false
    @Published var isPresentOnboarding = false
    
    init(){
        startTimer()
    }
    
    func startTimer() {
        var timerTime = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            if timerTime < 3 {
                timerTime += 1
                print(timerTime)
            }else {
                cheakFirstStart()
                timer.invalidate()
            }
        }
    }
    
    func cheakFirstStart() {
        if isFirstStart ?? true {
            isPresentOnboarding = true
        }else{
            isPresentMain = true
        }
    }
}
