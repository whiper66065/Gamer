//
//  DragonballView.swift
//  Gamer
//
//  Created by 潘昱任 on 2020/5/19.
//  Copyright © 2020 ntouyujen. All rights reserved.
//

import SwiftUI

struct DragonballView: View {
    @State private var show = false
    var body: some View {
        
        ZStack {
                    Image("dragonball")
                    .resizable()
                    .blur(radius: 8)
        //            Rectangle()
        //                .foregroundColor(.blue)
                    
                    VStack {
                        
                        TopicWord()
                            
                        VStack {
                            Image("gamecontroller")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350, height: 200)
                                .clipShape(Rectangle())
                                .overlay(Rectangle().stroke(Color.blue, lineWidth: 8))
                                .offset(x:0,y:-50)
                                
                            Text("您玩遊戲的好夥伴")
                            .font(.custom("jf-openhuninn-1.1", size: 35))
                                .foregroundColor(.green)
                                .background(Color.purple)
                                .padding()
                            
//                            .font(.system(size: 30))
//                                .fontWeight(.heavy)
//                            .foregroundColor(.yellow)
//                            .padding()
//                            .background(Color.red)
//                            .cornerRadius(10.0)
//                            .offset(x:0,y:50)
                        }
                        .offset(y: show ? 0 : 2000)
                            .scaleEffect(show ? 1 : 0.5)
                            .opacity(show ? 1 : 0)
                            .animation(.easeInOut(duration: 3))
                            .onAppear {
                                self.show = true
                        }
                    }
                }
            }
        }

struct DragonballView_Previews: PreviewProvider {
    static var previews: some View {
        DragonballView()
    }
}

struct TopicWord: View {
    var body: some View {
        VStack {
            Text("Game")
                .font(.custom("Nagurigaki Crayon", size: 130))
                .foregroundColor(.red)
                .padding()
                .offset(x:0,y:-40)
            Text("Paradise")
            .font(.custom("Nagurigaki Crayon", size: 80))
            .foregroundColor(.red)
            .padding()
            .offset(x:0,y:-60)
        }
    }
}
