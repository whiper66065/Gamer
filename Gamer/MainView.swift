//
//  MainView.swift
//  Gamer
//
//  Created by 潘昱任 on 2020/5/19.
//  Copyright © 2020 ntouyujen. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var gamesData = GamesData()
        var body: some View {
            TabView{
                DragonballView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("主頁")
                }
                GameList(gamesData: self.gamesData).tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("遊戲列表")
                }
                Analysis(gamesData: self.gamesData).tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("統計")
                }
            }
        }
    }

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
