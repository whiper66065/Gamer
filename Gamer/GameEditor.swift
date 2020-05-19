//
//  GameEditor.swift
//  Gamer
//
//  Created by 潘昱任 on 2020/5/19.
//  Copyright © 2020 ntouyujen. All rights reserved.
//

import SwiftUI

struct GameEditor: View {
    
    @Environment(\.presentationMode) var presentationMode
    var gamesData: GamesData
    @State private var showgameNameAlert = false
    @State private var showgameCompanyAlert = false
    @State private var gamename = ""
    @State private var gamecompany = ""
    @State private var gameplatform = 0
    @State private var finish = true
    let gameplatforms=["PS4","Switch","Xbox","PS3","PC"]
    @State private var showBlankAlert = false
    var editGameIndex: Int?
    
    var body: some View {
        VStack{
            Form {
                            TextField("遊戲名稱", text: $gamename, onEditingChanged: { (editing) in
                                print("onEditingChanged", editing)
                            }) {
                               print(self.gamename)
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                
                
                            TextField("遊戲公司", text: $gamecompany, onEditingChanged: { (editing) in
                                print("onEditingChanged", editing)
                            }) {
                               print(self.gamecompany)
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                
                
                            gameplatformType(gameplatform: self.$gameplatform)
                
                
                            Toggle("是否全破關", isOn: $finish)
                        }
            
            Image("dragonball")
            .resizable()
            
        }
                
                        .navigationBarTitle("編輯遊戲")
                        .navigationBarItems(trailing: Button("儲存") {
                            if self.gamename == ""
                            {
                                self.showgameNameAlert = true
                            }
                            else{
                            
                            let game = Game(gamename: self.gamename, gamecompany: self.gamecompany, gameplatform: self.gameplatform, finish: self.finish)
                            
                            if let editGameIndex = self.editGameIndex {
                                
                                self.gamesData.games[editGameIndex] = game
                            } else {
                                self.gamesData.games.insert(game, at: 0)
                            }

                            
                            self.presentationMode.wrappedValue.dismiss()
                            }}
                            .alert(isPresented: $showgameNameAlert)
                            {
                                () -> Alert in
                                return Alert(title: Text("錯誤!!"), message: Text("名字不得為空白"))
                            })
            
                            .onAppear {
                                
                                if let editGameIndex = self.editGameIndex {
                                    let editGame = self.gamesData.games[editGameIndex]
                                    self.gamename = editGame.gamename
                                    self.gamecompany = editGame.gamecompany
                                    self.gameplatform = editGame.gameplatform
                                    self.finish = editGame.finish
                                }
            }
        }
            }
        
struct GameEditor_Previews: PreviewProvider {
    static var previews: some View {
        GameEditor(gamesData: GamesData())
    }
}

struct gameplatformType: View
{
    @Binding var gameplatform: Int
    var gameplatforms=["PS4","Switch","Xbox","PS3","PC"]
    var body: some View{
        VStack{
        Text("遊戲平台")
        Picker(selection: $gameplatform, label: Text("遊戲平台")){
            ForEach(0..<gameplatforms.count) { (idx) in
                Text(self.gameplatforms[idx])
            }
        }
            
        
        .pickerStyle(SegmentedPickerStyle())
        }
    }
}
