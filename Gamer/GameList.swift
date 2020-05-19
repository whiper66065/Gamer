//
//  GameList.swift
//  Gamer
//
//  Created by 潘昱任 on 2020/5/19.
//  Copyright © 2020 ntouyujen. All rights reserved.
//

import SwiftUI

struct GameList: View {
    
    @ObservedObject var gamesData = GamesData()
    @State private var showEditGame = false
    
    var body: some View {
        
            NavigationView {
                List {
                    ForEach(gamesData.games.indices, id: \.self) { (index) in
                        NavigationLink(destination: GameEditor(gamesData: self.gamesData, editGameIndex: index)) {
                            GameRow(game: self.gamesData.games[index])
                        }
                    }
                    .onMove { (indexSet, index) in
                        self.gamesData.games.move(fromOffsets: indexSet,
                                        toOffset: index)
                    }
                    .onDelete { (indexSet) in
                        self.gamesData.games.remove(atOffsets: indexSet)
                    }
                    
                }
                .navigationBarTitle("遊戲列表")
                .navigationBarItems(leading: EditButton() , trailing: Button(action: {
                    self.showEditGame = true
                }) {
                    Image(systemName: "plus.rectangle.fill")
                    .foregroundColor(Color.green)
                    .font(.custom("jf-openhuninn-1.1", size: 30))
                })
                    .sheet(isPresented: $showEditGame) {
                        NavigationView {
                            GameEditor(gamesData: self.gamesData)

                        }
                }
            }
        }
    }


struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        GameList()
    }
}
