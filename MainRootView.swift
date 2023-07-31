//
//  MainRootView.swift
//  api-aqsha
//
//  Created by Alif on 30/07/23.
//

import Foundation
import SwiftUI

struct MainRootView : View {
    private var data:  [Int] = Array(1...6)
    private let colors: [Color] = [.red, .yellow, .blue, .green]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    
    
    var body : some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 25) {
                    
                    NavigationLink(destination: JokeApiView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.yellow)
                                .cornerRadius(30)
                            VStack{
                                Text("Jokes")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                    
                    NavigationLink(destination: CatFactView(), label:{
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.green)
                                .cornerRadius(30)
                            VStack{
                                Text("Cat Fact")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                    
                    NavigationLink(destination: DogApiView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.blue)
                                .cornerRadius(30)
                            VStack{
                                Text("Dogs")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                                Text("Random")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                        
                    
                    NavigationLink(destination: GuessAgeView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.red)
                                .cornerRadius(30)
                            VStack{
                                Text("Guess Age")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                    
                    
                    NavigationLink(destination: GuessGenderView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.orange)
                                .cornerRadius(30)
                            VStack{
                                Text("Guess")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                                Text("Gender")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                        
                    NavigationLink(destination: GeoIpView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.purple)
                                .cornerRadius(30)
                            VStack{
                                Text("Ip Info")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                }
            }
            .padding()
            .navigationTitle("Main Menu")
            .navigationBarBackButtonHidden()
        }
    }
}


struct MainRootView_Previews: PreviewProvider {
    static var previews: some View {
        MainRootView()
    }
}
