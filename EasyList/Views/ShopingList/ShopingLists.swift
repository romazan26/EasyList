//
//  ShopingLists.swift
//  EasyList
//
//  Created by Роман on 13.01.2025.
//

import SwiftUI

struct ShopingLists: View {
    @StateObject var vm: ShoppingListViewModel
    var body: some View {
        ZStack {
            //MARK: - Background
            Color.main.ignoresSafeArea()
            
            //MARK: - Main stack
            VStack {
                //MARK: - Top toolbar
                HStack {
                    Text("Shopping lists")
                        .foregroundStyle(.black)
                        .font(.system(size: 22, weight: .bold))
                }
                Divider()
                
                //MARK: - List shopping
                ZStack(alignment: .bottom) {
                    if vm.shoppingLists.isEmpty{
                        //MARK: - No shopping item
                        VStack {
                            Spacer()
                            Image(.noList)
                                .resizable()
                                .frame(width: 128, height: 128)
                            Text("No shopping lists yet. \nTap «+» below to create one.")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.black)
                                .font(.system(size: 16))
                            Spacer()
                        }
                    }else{
                        ScrollView {
                            ForEach(vm.shoppingLists) { list in
                                if !list.archive{
                                    Button {
                                        vm.tapList(list: list)
                                    } label: {
                                        ShoppingListCellView(list: list, vm: vm)
                                    }
                                }
                                
                            }
                        }
                    }
                    
                    //MARK: - Add button
                    HStack {
                        Spacer()
                        Button {
                            vm.presentAddView()
                        } label: {
                            ZStack {
                                Color.second.cornerRadius(10)
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.black)
                            }.frame(width: 48, height: 48)
                        }
                    }
                }
            }
            .padding()
            .fullScreenCover(isPresented: $vm.isPresentAddView) {
                AddListView(vm: vm)
            }
            .fullScreenCover(isPresented: $vm.isPresentListView) {
                ListView(vm: vm)
            }
        }
    }
}
#Preview {
    ShopingLists(vm: ShoppingListViewModel())
}
