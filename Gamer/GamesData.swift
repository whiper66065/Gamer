//
//  GamesData.swift
//  Gamer
//
//  Created by 潘昱任 on 2020/5/19.
//  Copyright © 2020 ntouyujen. All rights reserved.
//

import Foundation

class GamesData: ObservableObject {
    @Published var games = [Game](){
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(games){
                UserDefaults.standard.set(data, forKey:"games")
            }
        }
    }
    
    init(){
        if let data =
            UserDefaults.standard.data(forKey:"games"){
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Game].self, from:data){
                games = decodedData
            }
        }
    }
}
