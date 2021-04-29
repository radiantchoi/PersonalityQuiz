//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Gordon Choi on 2021/04/29.
//

import UIKit

final class ResultsViewController: UIViewController {
    @IBOutlet private var resultAnswerLabel: UILabel!
    @IBOutlet private var resultDefinitionLabel: UILabel!
    
    var responses: [Answer]!
}

extension ResultsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
    }
}

extension ResultsViewController {
    private func calculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map { $0.type }
        for response in responseTypes {
            let newCount: Int
            
            if let oldCount = frequencyOfAnswers[response] {
                newCount = oldCount + 1
            } else {
                newCount = 1
            }
            
            frequencyOfAnswers[response] = newCount
        }
        
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: { (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
}

