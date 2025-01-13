//
//  IntroView.swift
//  FastTrack
//
//  Created by Роман on 12.08.2024.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("isFirstStart") private var isFirstLaunch: Bool?
    
    @State private var isPresented = false
    @State private var pageIndex = 0
    @Environment(\.dismiss) var dismiss
    
    private let pages: [PageIntro] = PageIntro.sampalePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Color.main.ignoresSafeArea()
            TabView(selection: $pageIndex,
                    content:  {
            
                        Image(pages[pageIndex].imageUrl)
                            .resizable()
                            .padding()
                            
            })
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            
            VStack(alignment: .leading){
                Text(pages[pageIndex].title)
                    .font(.system(size: 28, weight: .bold))

                Text(pages[pageIndex].text)
                    .font(.system(size: 16))
                //MARK: - Navigation Button
                Button(action: {
                    if pageIndex > pages.count - 2 {
                        isPresented = true
                        if isFirstLaunch ?? true{
                            isFirstLaunch = false
                        }
                    }else{
                        pageIndex += 1
                    }
                }, label: {
                    HStack {
                        ZStack{
                            Color(pageIndex > pages.count - 2 ? .second : .blue)
                                .cornerRadius(10)
                            Text(pageIndex > pages.count - 2 ? "Skip" : "Next")
                                .foregroundStyle(pageIndex > pages.count - 2 ? .black : .white)
                        }.frame(height: 36)
                        if pageIndex > pages.count - 2 {
                            Button {
                                if pageIndex > pages.count - 2 {
                                    isPresented = true
                                    if isFirstLaunch ?? true{
                                        isFirstLaunch = false
                                    }
                                }else{
                                    pageIndex += 1
                                }
                            } label: {
                                Image(systemName: "plus.app.fill")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .foregroundStyle(.blue)
                                    
                            }

                        }
                    }
                }).padding()
                
                //MARK: - Progress idicator
                HStack{
                    Spacer()
                    ForEach(0..<pages.count) { page in
                        if pageIndex == page{
                            Circle()
                                .frame(height: 10)
                                .foregroundStyle(.blue)
                        }else{
                            Circle()
                                .frame(height: 10)
                                .foregroundStyle(.gray)
                        }
                    }
                    Spacer()
                }
            }
            .padding()
            .background {
                Color.white.ignoresSafeArea()
            }
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            RootView()
        })
        
    }
    
}

#Preview {
    IntroView()
}

