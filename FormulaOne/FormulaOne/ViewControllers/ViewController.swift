//
//  ViewController.swift
//  FormulaOne
//
//  Created by Anton Pogorelov on 23.04.2021.
//

import UIKit

class ViewController: UIViewController {

    var userData: UserData?
    
    // MARK: - IBOutlets
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var recordsButton: UIButton!

    // MARK: - Lifestyle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        gameButton.addShadow(color: .gray, radius: 7, offset: .zero, opacity: 0.5)
        settingsButton.addShadow(color: .gray, radius: 7, offset: .zero, opacity: 0.5)
        recordsButton.addShadow(color: .gray, radius: 7, offset: .zero, opacity: 0.5)

        gameButton.addCornerRadius(cornerRadius: 20)
        settingsButton.addCornerRadius(cornerRadius: 20)
        recordsButton.addCornerRadius(cornerRadius: 20)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - IBAcitons
    @IBAction private func onGameButton(_ sender: UIButton) {
        let gameView = GameViewController.instantiate()
        gameView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(gameView, animated: true)
    }
    @IBAction private func onSettingsButton(_ sender: UIButton) {
        let settingsView = SettingsViewController.instantiate()
        settingsView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(settingsView, animated: true)
    }
    @IBAction private func onRecordsAction(_ sender: UIButton) {
        let recordsView = RecordsViewController.instantiate()
        recordsView.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(recordsView, animated: true)
    }
}
