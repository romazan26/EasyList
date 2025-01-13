//
//  ArchiveView.swift
//  EasyList
//
//  Created by Роман on 13.01.2025.
//

import SwiftUI

struct ArchiveView: View {
    @StateObject var vm: ShoppingListViewModel
    var body: some View {
        ZStack {
            //MARK: - Background
            Color.main.ignoresSafeArea()
            
            //MARK: - Main stack
            VStack {
                //MARK: - Top toolbar
                HStack {
                    Text("Archive")
                        .foregroundStyle(.black)
                        .font(.system(size: 22, weight: .bold))
                }
                Divider()
                
                //MARK: - List shopping
                ZStack(alignment: .bottom) {
                    if vm.archiveList.isEmpty{
                        //MARK: - No shopping item
                        VStack {
                            Spacer()
                            Image(.noArchive)
                                .resizable()
                                .frame(width: 128, height: 128)
                            Text("You haven't archived your shopping lists yet.")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.black)
                                .font(.system(size: 16))
                            Spacer()
                        }
                    }else{
                        ScrollView {
                            ForEach(vm.archiveList) { list in
                                Button {
                                    vm.tapArchiveList(list: list)
                                } label: {
                                    ShoppingListCellView(list: list, vm: vm)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .fullScreenCover(isPresented: $vm.isPresentArchiveView) {
                ArchiveListView(vm: vm)
            }
        }
    }
}

#Preview {
    ArchiveView(vm: ShoppingListViewModel())
}
