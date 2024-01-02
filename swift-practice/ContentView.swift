//
//  ContentView.swift
//  swift-practice
//
//  Created by 狩野悟 on 2023/12/29.
//

import SwiftUI


let heightSize = UIScreen.main.bounds.height
let widthSize = UIScreen.main.bounds.width
struct ContentView: View {
    @State var tappedLocation: CGPoint? = nil
    @State var barLocation = widthSize / 2
    @State var ballLocation = CGPoint(x: widthSize / 2, y: heightSize / 1.5 - 20)
    @State var ballVector = CGPoint(x: 1, y: 1)
    @State var timer: Timer?
    @State var gameStart = false
    @State var blockDict = [CGPoint(x:widthSize / 4, y: heightSize / 3)]
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.primary)
                .frame(width: widthSize / 4, height: 30)
                .position(x: widthSize / 4, y: heightSize / 3)
            Rectangle()
                .foregroundColor(.primary)
                .frame(width: 30, height: 30)
                .position(x: ballLocation.x, y: ballLocation.y)
                .padding(0)
            Rectangle()
                .foregroundColor(.primary)
                .frame(width: 100, height: 10)
                .position(x: barLocation, y: heightSize / 1.5)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged {value in
                            if value.location.x < 50 {
                                barLocation = 50
                            } else if value.location.x > widthSize - 50{
                                barLocation = widthSize - 50
                            } else {
                                barLocation = value.location.x
                            }
                            if !gameStart {
                                ballLocation.x = barLocation
                            }
                        }
                        .onEnded {_ in
                            if !gameStart {
                                gameStart = true
                                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {_ in
                                    ballMove()
                                }
                            }
                            
                        }
                )
        }
        
    }
    func ballMove() {
        if ballLocation.x < 15 || ballLocation.x > widthSize - 15 {
            ballVector.x *= -1
        }
        
        if ballLocation.y < 0 {
            ballVector.y *= -1
        }
        
        if ballLocation.x < barLocation + 50 && ballLocation.x > barLocation - 50 && ballLocation.y > heightSize / 1.5 - 1.5 && ballLocation.y < heightSize / 1.5 + 1.5{
            ballVector.y *= -1
        }
        
        if ballLocation.x < widthSize / 4 + widthSize / 8 && ballLocation.x > widthSize / 4 - widthSize / 8 && ballLocation.y > heightSize / 3 - 1.5 && ballLocation.y < heightSize / 3 + 1.5{
            ballVector.y *= -1
        }
        ballLocation.x -= ballVector.x * 2
        ballLocation.y -= ballVector.y * 2
        
    }
}




#Preview {
    ContentView()
}
