//
//  ContentView.swift
//  QuizApp
//
//  Created by samar salem on 08/02/2023.
//

import SwiftUI

struct ContentView: View {
    var questions = [Quiz(question: "What day is it?",
                          option1: "Monday",
                          option2: "Saturday",
                          option3: "Wednesday",
                          option4: "Friday"),
                     Quiz(question: "What framework are we using?",
                          option1: "UIKit",
                          option2: "SwiftUI",
                          option3: "React Native",
                          option4: "Flutter"),
                     Quiz(question: "Which company created Swift?",
                          option1: "Orange",
                          option2: "Apple",
                          option3: "Google",
                          option4: "Tinkercademy")]
    
    @State var currentQuestionIndex = 0
    @State var alertShown = false
    @State var isCorrect = false
    @State var score = 0
    @State var isScoreShown = false
    @State var timer = 10
    @State private var sec : Timer?
    @State private var isCounterRunning = false
    
    //animation
    @State var isPressed = false
    @State private var punchlineSize: CGFloat = 0.1
    @State private var punchlineRotation: Angle = .zero
    @State private var opacity: Double = 0
    @State private var tapToContinueOffset: CGFloat = 50
    
    var body: some View {
        VStack(alignment: .center, spacing: 30){
            Text("Question \(currentQuestionIndex+1)")
                .font(.system(size: 50))
                .bold()
            Text("Timer \(timer)")
                .onAppear{
                    if !isCounterRunning{
                        sec = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { sec in
                            self.timer -= 1
                            
                            if timer <= 0 {
                                isCorrect = false
                                alertShown = true
                            }
                            
                        }
                    }else{
                        
                        sec?.invalidate()
                        
                    }
                    
                }
            Text(questions[currentQuestionIndex].question)
                .font(.largeTitle)
            
            HStack(alignment: .center, spacing: 20){
                Button{
                    isCorrect = false
                    alertShown = true
                    isPressed.toggle()
                    
                }label: {
                    Text(questions[currentQuestionIndex].option1)
                        .padding()
                        .frame(width: 150, height: 50)
                        .font(.callout)
                        .background(.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .scaleEffect(isPressed ? 1.2 : 1)
                .animation(.easeInOut(duration: 0.5))
                
                
                
                Button{
                    isCorrect = true
                    alertShown = true
                    score += 1
                }label: {
                    Text(questions[currentQuestionIndex].option2)
                        .padding()
                        .frame(width: 150, height: 50)
                        .font(.callout)
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
            HStack(alignment: .center, spacing: 20){
                Button{
                    isCorrect = false
                    alertShown = true
                }label: {
                    Text(questions[currentQuestionIndex].option3)
                        .padding()
                        .frame(width: 150, height: 50)
                        .font(.callout)
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button{
                    isCorrect = false
                    alertShown = true
                }label: {
                    Text(questions[currentQuestionIndex].option4)
                        .padding()
                        .frame(width: 150, height: 50)
                        .font(.callout)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
        }
        .padding()
        .alert(isCorrect ? "Correct" : "Worng", isPresented: $alertShown) {
            Button("ok"){
                isPressed = false
                currentQuestionIndex += 1
                timer = 10
                let index = questions.count - 1
                if(currentQuestionIndex > index)
                {
                    currentQuestionIndex = 0
                    isScoreShown = true
                }
                
            }
        }message: {
            Text(isCorrect ? "Congrats" : "How can you be getting this wrong!!")
        }
        .sheet(isPresented: $isScoreShown){
            ScoreView(score: score, total: questions.count)
                .onDisappear{
                    currentQuestionIndex = 0
                    timer = 10
                    score = 0
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
