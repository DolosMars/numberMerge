//
//  ContentView.swift
//  numberMerge
//
//  Created by User06 on 2022/4/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("score") var bestScore: Int = 0
    @State private var  game = Array(repeating: 0, count: 33)
    @State var score = 0
    @State var nextNum = 0
    @State private var showAlert = false
    
    func merge(i:Int, j:Int) -> Bool{
        var state: Bool = false
        if (5*(i-1)+j >= 0){
            if (game[5*(i-1)+j] == game[5*i+j]){
                game[5*(i-1)+j] = 0
                state = true
            }}
        if (5*(i+1)+j <= 24){
            if (game[5*(i+1)+j] == game[5*i+j]){
                game[5*(i+1)+j] = 0
                state = true
            }}
        if (5*i+(j-1) >= 0){
            if (game[5*i+(j-1)] == game[5*i+j]){
                game[5*i+(j-1)] = 0
                state = true
            }}
        if (5*i+(j+1) <= 24){
            if (game[5*i+(j+1)] == game[5*i+j]){
                game[5*i+(j+1)] = 0
                state = true
            }}
        if (state == true){
            game[5*i+j] += 1
        }
        return state
    }
    
    func endState() -> Bool {
        var state: Bool = true
        
        for i in 0...24{
            if(game[i] == 0){
                state = false
            }
        }
        
        return state
        
    }
    var body: some View {
        VStack{
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color(red: 0.94, green: 0.96, blue: 0.95))
                    VStack{
                        Text("Score")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.55, green: 0.66, blue: 0.62))
                        Text("\(score)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.55, green: 0.66, blue: 0.62))
                    }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color(red: 0.94, green: 0.96, blue: 0.95))
                    VStack{
                        Text("Best")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.55, green: 0.66, blue: 0.62))
                        Text("\(bestScore)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.55, green: 0.66, blue: 0.62))
                    }
                }
                
            }.offset(x: 0, y: -20)
            HStack{
                ForEach(0..<5){ i in
                    VStack{
                        ForEach(0..<5){ j in
                            if (game[5*i+j] == 0){
                                Image(systemName: "square.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(red: 0.75, green: 0.80, blue: 0.79))
                                    .onTapGesture {
                                        game[5*i+j] = nextNum
                                        var state:Bool = merge(i: i, j: j)
                                        score += 1
                                        while(state)
                                        {
                                            state = merge(i: i, j: j)
                                            score += 1
                                        }
                                        nextNum = Int.random(in: 1...3)
                                        if(endState() == true){
                                            if (score > bestScore){
                                                bestScore = score
                                            }
                                            showAlert = true
                                        }
                                    }
                            }else{
                                Image(systemName: "\(game[5*i+j]).square")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(red: 0.94, green: 0.96, blue: 0.95))
                            }
                            
                        }
                    }
                }
            }
            Image(systemName: "\(nextNum).square")
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55)
                .foregroundColor(Color(red: 0.94, green: 0.96, blue: 0.95))
                .offset(x: 0, y: 20)
            
            Button{
                for i in 0...24{
                    game[i] = 0
                }
                score = 0
            } label:{
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 110, height: 30)
                        .foregroundColor(Color(red: 0.94, green: 0.96, blue: 0.95))
                    
                    Text("New Game")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.55, green: 0.66, blue: 0.62))
                    
                }
            }.offset(x: 0, y: 25)
        }.onAppear{
            nextNum = Int.random(in: 1...3)
        }.alert(isPresented: $showAlert, content: {
            return Alert(
                title: Text("Game Over!"),
                message: Text("Your Score : \(score) \n Best Score : \(score)")
                
            )
            
        })
        .frame(width: 800, height: 800)
        .background(Color(red: 0.55, green: 0.66, blue: 0.62))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
