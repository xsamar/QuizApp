//
//  ScoreView.swift
//  QuizApp
//
//  Created by samar salem on 08/02/2023.
//

import SwiftUI

struct ScoreView: View {
    var score : Int
    var total : Int
    var body: some View {
        Text("Result \(score) / \(total)")
            .font(.largeTitle)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 1, total: 2)
    }
}
