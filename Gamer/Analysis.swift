//
//  Analysis.swift
//  Gamer
//
//  Created by 潘昱任 on 2020/5/19.
//  Copyright © 2020 ntouyujen. All rights reserved.
//

import SwiftUI

struct Analysis: View {
    @ObservedObject var gamesData =
        GamesData()
        let gameplatforms=["PS4","Switch","Xbox","PS3","PC"]
        @State private var selectedAnalyzeItem = "破關統計"
        var analyzeItems = ["破關統計", "遊戲平台統計",]
        var gameplatformAngles: [Angle]
        var gameplatformCount: [Double] = [0,0,0,0,0]
        var finishCount: Double = 0
        var finishAngles: [Angle]
        var finishPercent: Double = 0
        
        init(gamesData: GamesData)
        {
            self.gamesData = gamesData
            
            var totalCount: Double = 0
            
            for data in gamesData.games
            {
                totalCount += 1
                for idx in 0...4{
                    if idx == data.gameplatform{
                        gameplatformCount[idx] += 1
                    }
                }
                if data.finish == true{
                    finishCount += 1
                }
            }
            var Percentages: [Double] = [0,0,0,0,0]
            Percentages[0] = gameplatformCount[0] / totalCount
            Percentages[1] = gameplatformCount[1] / totalCount
            Percentages[2] = gameplatformCount[2] / totalCount
            Percentages[3] = gameplatformCount[3] / totalCount
            Percentages[4] = gameplatformCount[4] / totalCount
            gameplatformAngles = [Angle]()
            var StartDegree: Double = 0
            for Percentages in Percentages
            {
                gameplatformAngles.append(.degrees(StartDegree))
                StartDegree += 360 * Percentages
            }
            if Percentages[4] == 1.0
            {
                gameplatformAngles[0] = .degrees(360)
            }
            
            var percentage: [Double] = [0,0]
            percentage[0] = finishCount / totalCount
            percentage[1] = (totalCount-finishCount) / totalCount
            finishPercent = (totalCount-finishCount) / totalCount
            finishAngles = [Angle]()
            var startDegree: Double = 0
            for percentage in percentage
            {
                finishAngles.append(.degrees(startDegree))
                startDegree += 360 * percentage
            }
            if percentage[1] == 1.0
            {
                finishAngles[0] = .degrees(360)
            }
        }
        
        var body: some View {
            
            ZStack {
                Image("dragonball")
                .resizable()
                .blur(radius: 10)
                
                
                VStack {
                    Text("要查看哪個統計圖：")
                    .font(.custom("jf-openhuninn-1.1", size: 40))
                    .foregroundColor(.green)
                    .background(Color.purple)
                    .padding()
                        .offset(x:0,y:-100)
                    Picker(selection: self.$selectedAnalyzeItem, label: Text("要查看哪個統計圖："))
                    {
                        ForEach(self.analyzeItems, id: \.self)
                        {
                            (analyzeItem) in
                            Text(analyzeItem)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(20)
                        .frame(width:400, height:100)
                    .offset(x:0,y:-100)
                    if self.gamesData.games.count != 0
                    {
                        if self.selectedAnalyzeItem == "破關統計"
                        {
                            resultCircleChart(finishPercent: self.finishPercent)
                        }
                        else if self.selectedAnalyzeItem == "遊戲平台統計"
                        {
                          resultPieChart(gameplatformAngles: self.gameplatformAngles)
                        }
                    }
                    else
                    {
                        Text("目前沒有遊戲記錄！！")
                        .font(Font.system(size:30))
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        .multilineTextAlignment(.center)
                        .frame(width:300, height:300)
                         .background(Color.gray)
                         .cornerRadius(150)
                    }
                }
            }
        }
    }

struct Analysis_Previews: PreviewProvider {
    static var previews: some View {
        Analysis(gamesData: GamesData())
    }
}

struct resultPieChart: View
{
    var gameplatformAngles: [Angle]
    var body: some View
    {
        VStack//(totalHeight:270)
        {
            ZStack//(height:200)
            {
                Group{
                PieChart(startAngle: gameplatformAngles[0], endAngle: gameplatformAngles[1])
                .fill(Color.red)
                PieChart(startAngle: gameplatformAngles[1], endAngle: gameplatformAngles[2])
                .fill(Color.purple)
                PieChart(startAngle: gameplatformAngles[2], endAngle: gameplatformAngles[3])
                .fill(Color.yellow)
                PieChart(startAngle: gameplatformAngles[3], endAngle: gameplatformAngles[4])
                .fill(Color.green)
                PieChart(startAngle: gameplatformAngles[4], endAngle: gameplatformAngles[0])
                .fill(Color.blue)
                }
                .offset(x:0, y: -100)
                
                VStack{
                    HStack{
                    Circle()
                    .fill(Color.red)
                    .frame(width: 20, height: 20)
                    
                    Text("PS4")
                    
                    Circle()
                    .fill(Color.purple)
                    .frame(width: 20, height: 20)
                    
                    Text("Switch")
                    }
                    
                    Group{
                        HStack{
                    Circle()
                    .fill(Color.yellow)
                    .frame(width: 20, height: 20)
                    
                    Text("Xbox")
                    
                    Circle()
                    .fill(Color.green)
                    .frame(width: 20, height: 20)
                    Text("PS3")
                    Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    Text("PC")
                        }
                    }
                    
                    
                }.offset(x:0, y: 100)
            }
            .frame(width: 200, height: 200)
            Spacer()//(height:40)
            .frame(height:30)
           // genderIcons()//(height:30)

            /*Form
            {
                boyIcon()
                girlIcon()
                otherIcon()
            }*/
        }
        //.animation(.default)
    }
}

struct resultCircleChart: View {
    var finishPercent: Double
    var body: some View {
        
        VStack {
            Text(String(format:"%.0f%%的遊戲已破關", 100-(finishPercent * 100)))
                .font(Font.system(size:30))
                
            ZStack {
                Circle()
                    .stroke(Color.red, lineWidth: 20)
                Circle()
                    .trim(from: 0, to: CGFloat(finishPercent))
                    .stroke(Color.gray, lineWidth: 20)
                
                
                HStack{
                    Circle()
                        .fill(Color.red)
                    .frame(width: 20, height: 20)
                    Text("已破關")
                    Circle()
                    .fill(Color.gray)
                    .frame(width: 20, height: 20)
                    Text("未破關")
                }.offset(x:0, y: 160)
            }.frame(width: 200, height: 200)
        }
    }
}
