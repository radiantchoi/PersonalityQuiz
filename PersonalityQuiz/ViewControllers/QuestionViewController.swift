//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Gordon Choi on 2021/04/29.
//

import UIKit

final class QuestionViewController: UIViewController {
    
    @IBOutlet private var questionLabel: UILabel!
    
    @IBOutlet private var singleStackView: UIStackView!
    @IBOutlet private var singleButton1: UIButton!
    @IBOutlet private var singleButton2: UIButton!
    @IBOutlet private var singleButton3: UIButton!
    @IBOutlet private var singleButton4: UIButton!
    
    @IBOutlet private var multipleStackView: UIStackView!
    @IBOutlet private var multiLabel1: UILabel!
    @IBOutlet private var multiLabel2: UILabel!
    @IBOutlet private var multiLabel3: UILabel!
    @IBOutlet private var multiLabel4: UILabel!
    @IBOutlet private var multiSwitch1: UISwitch!
    @IBOutlet private var multiSwitch2: UISwitch!
    @IBOutlet private var multiSwitch3: UISwitch!
    @IBOutlet private var multiSwitch4: UISwitch!
    
    @IBOutlet private var rangedStackView: UIStackView!
    @IBOutlet private var rangedLabel1: UILabel!
    @IBOutlet private var rangedLabel2: UILabel!
    @IBOutlet private var rangedSlider: UISlider!
    
    @IBOutlet private var questionProgressView: UIProgressView!
    
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
    var answersChosen: [Answer] = []
    
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
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    private func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    private func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    private func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
}


extension QuestionViewController {
    
    @IBAction private func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction private func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction private func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
}
