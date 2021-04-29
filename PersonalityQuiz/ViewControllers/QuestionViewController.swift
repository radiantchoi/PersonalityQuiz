//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Gordon Choi on 2021/04/29.
//

import UIKit

final class QuestionViewController: UIViewController {

    @IBOutlet private var singleStackView: UIStackView!
    @IBOutlet private var multipleStackView: UIStackView!
    @IBOutlet private var rangedStackView: UIStackView!
    
    private var questions: [Question] = [
        Question(text: "Which food do you like the most?", type: .single, answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)]),
        Question(text: "Which activities do you enjoy?", type: .multiple, answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)]),
        Question(text: "How much do you enjoy car rides?", type: .ranged, answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "I love them", type: .dog)])
        ]
    
    private var questionIndex = 0
}

extension QuestionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}

extension QuestionViewController {
    private func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex)"
        
        let currentQuestion = questions[questionIndex]
        
        switch currentQuestion.type {
        case .single:
            singleStackView.isHidden = false
        case .multiple:
            multipleStackView.isHidden = false
        case .ranged:
            singleStackView.isHidden = false
        }
    }
}
