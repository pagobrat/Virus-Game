//
//  EndGameViewController.swift
//  FormulaOne
//
//  Created by Anton Pogorelov on 23.04.2021.
//

import UIKit

class EndGameViewController: UIViewController {
    // MARK: - Public properties
    var lastRecord = ""
    var recordsArray = [String]()

    // MARK: - IBOutlets
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var goToMenuButton: UIButton!
    @IBOutlet weak var record: UILabel!

    // MARK: - Lifestyle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        restartButton.addShadow(color: .gray, radius: 7, offset: .zero, opacity: 0.5)
        goToMenuButton.addShadow(color: .gray, radius: 7, offset: .zero, opacity: 0.5)

        restartButton.addCornerRadius(cornerRadius: 25)
        goToMenuButton.addCornerRadius(cornerRadius: 25)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if UserDefaults.standard.value(forKey: "userRecord") != nil {
            record.text = UserDefaults.standard.value(forKey: "userRecord") as? String
        } else {
            return
        }
        lastRecord = record.text ?? ""
        saveRecords()
    }

    // MARK: - IBActions
    @IBAction private func onRestartButton(_ sender: UIButton) {
        let gameView = GameViewController.instantiate()
        gameView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(gameView, animated: true)
    }
    @IBAction private func onGoToMenuButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Other functions
    func saveRecords() {
        let data = Date()
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(data).txt")
        let userScore = String("\(record)")
        do {
            try userScore.write(to: path, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
        var inString = ""
        do {
            inString = try String(contentsOf: path)
        } catch {
            print("Failed reading from URL: \(userScore), Error: " + error.localizedDescription)
        }
        print("Read from the file: \(inString)")
        print(path)

        if UserDefaults.standard.value(forKey: "lastRecord") != nil {
            recordsArray = UserDefaults.standard.value(forKey: "lastRecord") as? Array ?? []
            let lastUserRecord = lastRecord
            recordsArray.append(lastUserRecord)
            UserDefaults.standard.setValue(recordsArray, forKey: "lastRecord")
        } else {
            recordsArray.append(lastRecord)
            UserDefaults.standard.setValue(self.recordsArray, forKey: "lastRecord")
            return
        }
    }
}
