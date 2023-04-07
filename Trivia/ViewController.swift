//
//  ViewController.swift
//  Trivia
//
//  Created by isa adem on 2/18/25.
//
import UIKit

struct Question {
    let text: String
    let answers: [String]
    let correctAnswer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var progressLabel: UILabel!

    var questions: [Question] = [
        Question(text: "What is the capital of France?", answers: ["Berlin", "Madrid", "Paris", "Rome"], correctAnswer: "Paris"),
        Question(text: "Which planet is known as the Red Planet?", answers: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswer: "Mars"),
        Question(text: "How many continents are there?", answers: ["5", "6", "7", "8"], correctAnswer: "7")
    ]

    var currentQuestionIndex = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
    }

    func updateUI() {
        // Updates the UI with the current question and answers.
        let currentQuestion = questions[currentQuestionIndex]
        labelQuestion.text = currentQuestion.text
        answerButton1.setTitle(currentQuestion.answers[0], for: .normal)
        answerButton2.setTitle(currentQuestion.answers[1], for: .normal)
        answerButton3.setTitle(currentQuestion.answers[2], for: .normal)
        answerButton4.setTitle(currentQuestion.answers[3], for: .normal)
        progressLabel.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"
    }

    @IBAction func answerSelected(_ sender: UIButton) {
        // Called when a user selects an answer.
        checkAnswer(sender)
    }

    func checkAnswer(_ sender: UIButton) {
        // Compares the selected answer with the correct answer.
        // If correct, increment the score.
        let correctAnswer = questions[currentQuestionIndex].correctAnswer

        if sender.currentTitle == correctAnswer {
            score += 1
        }

        nextQuestion()
    }

    func nextQuestion() {
        // Moves to the next question or ends the game if all questions are answered.
        currentQuestionIndex += 1

        if currentQuestionIndex < questions.count {
            updateUI()
        } else {
            endGame()
        }
    }

    func endGame() {
        // Displays the final score and provides an option to restart the game.
        let alert = UIAlertController(
            title: "Game Over",
            message: "You got \(score) out of \(questions.count) correct!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.restartGame()
        }))
        present(alert, animated: true)
    }

    func restartGame() {
        // Resets the game variables and starts over.
        currentQuestionIndex = 0
        score = 0
        updateUI()
    }
}
