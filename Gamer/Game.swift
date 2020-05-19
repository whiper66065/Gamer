//
//  Game.swift
//  Gamer
//
//  Created by 潘昱任 on 2020/5/19.
//  Copyright © 2020 ntouyujen. All rights reserved.
//

import Foundation

struct Game: Identifiable, Codable {
    let id = UUID()
    var gamename: String
    var gamecompany: String
    var gameplatform: Int
    var finish: Bool
}
