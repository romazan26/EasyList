//
//  PageIntroModel.swift
//  AircraftInspection
//
//  Created by Роман on 05.04.2024.
//

import Foundation

struct PageIntro: Identifiable,Equatable {
    let id = UUID()
    var imageUrl: String
    var title: String
    var text: String
    var tag: Int

    static var samplePage = PageIntro(imageUrl: "onboard1", title: "Welcome to EasyList!", text: "Quickly create, manage, and check off your shopping lists in just a few taps", tag: 0)
    
    static var sampalePages: [PageIntro] = [
        PageIntro(imageUrl: "onboard1", title: "Welcome to EasyList!", text: "Quickly create, manage, and check off your shopping lists in just a few taps", tag: 0),
        PageIntro(imageUrl: "onboard2", title: "Add items effortlessly", text: "Organize your list with quantities and units for a stress-free shopping experience", tag: 1),
        PageIntro(imageUrl: "onboard3", title: "You're all set!", text: "Tap the «+» button to create your first list and simplify your shopping today..", tag: 1)
    ]
}
