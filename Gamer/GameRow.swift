//
//  GameRow.swift
//  Gamer
//
//  Created by 潘昱任 on 2020/5/19.
//  Copyright © 2020 ntouyujen. All rights reserved.
//

import SwiftUI

struct GameRow: View {
    
    var game: Game
    let gameplatforms=["PS4","Switch","Xbox","PS3","PC"]

    var body: some View {
        HStack {
            Text(game.gamename)
            .font(.custom("jf-openhuninn-1.1", size: 20))
            .foregroundColor(.blue)
            .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("遊戲公司：")
                    .font(.custom("jf-openhuninn-1.1", size: 10))
                    .foregroundColor(.orange)
                        .padding()
                    Text(game.gamecompany)
                    .font(.custom("jf-openhuninn-1.1", size: 15))
                    .foregroundColor(.red)
                        .padding()
                }
                
                HStack{
                Text("遊戲平台：")
                .font(.custom("jf-openhuninn-1.1", size: 10))
                .foregroundColor(.orange)
                .padding()
                Text("\(gameplatforms[game.gameplatform])")
                .font(.custom("jf-openhuninn-1.1", size: 15))
                .foregroundColor(.red)
                    .padding()
                }
            }
            Spacer()
            Image(systemName: game.finish ? "checkmark.shield.fill" : "checkmark.shield")
                .foregroundColor(Color.red)
            .font(.custom("jf-openhuninn-1.1", size: 25))
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: Game(gamename: "蜘蛛人", gamecompany: "漫威", gameplatform: 0, finish: true))
        .previewLayout(.sizeThatFits)
    }
}

