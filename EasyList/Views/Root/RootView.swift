//
//  RootVView.swift
//  EasyList
//
//  Created by Роман on 13.01.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject var vmShopping = ShoppingListViewModel()
    init(){
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .second
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            ShopingLists(vm: vmShopping)
                .tabItem {
                    VStack{
                        Image(systemName: "basket")
                        Text("Shopping lists")
                    }
                }
            
            ArchiveView(vm: vmShopping)
                .tabItem {
                    VStack{
                        Image(systemName: "archivebox")
                        Text("Archive")
                    }
                }
            
            SettingsView()
                .tabItem {
                    VStack{
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                }
        }.tint(.black)
    }
}

#Preview {
    RootView()
}
