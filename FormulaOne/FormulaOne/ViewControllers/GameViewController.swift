//
//  GameViewController.swift
//  FormulaOne
//
//  Created by Anton Pogorelov on 23.04.2021.
//

import UIKit

class GameViewController: UIViewController {
    // MARK: - Public properties
    private var choosenMobile = ""
    private var choosenVirus = ""
    private var userName = ""
    private var score = 0
    private var timerForVirus = Timer()
    var userData: UserData?
    let dateFormatter = DateFormatter()

    // MARK: - IBOutlets
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var firstVirusImage: UIImageView!
    @IBOutlet private weak var secondVirusImage: UIImageView!
    @IBOutlet private weak var mobileImage: UIImageView!

    // MARK: - Lifestyle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        animateViruses()
        choosenUserSettings()

        mobileImage.image      = UIImage(named: "\(choosenMobile)")
        firstVirusImage.image  = UIImage(named: "\(choosenVirus)")
        secondVirusImage.image = UIImage(named: "\(choosenVirus)")

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timerForScore) in
            self.score += 1
            self.scoreLabel.text = "Score: \(self.score)"
        }
        timerForVirus = Timer.scheduledTimer(timeInterval: 0.004, target: self, selector: #selector(animateViruses), userInfo: nil, repeats: true)
    }
    // MARK: - IBAction
    @IBAction private func onMobilePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

    // MARK: - Others functions
    @objc private func animateViruses() {
        saveRecord()
        moveViruses(virus: firstVirusImage)
        moveViruses(virus: secondVirusImage)

        if self.firstVirusImage.layer.presentation()?.frame.intersects(self.mobileImage.frame) == true ||
            self.secondVirusImage.layer.presentation()?.frame.intersects(self.mobileImage.frame) == true {
            self.timerForVirus.invalidate()

            let endGameView = EndGameViewController.instantiate()
            endGameView.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(endGameView, animated: true)
        }
    }

    private func moveViruses(virus: UIImageView) {
        if virus.frame.origin.y > view.frame.height {
            virus.frame.origin.y = CGFloat(Int.random(in: (-600)...0))
        } else {
            virus.frame = CGRect(x: virus.frame.origin.x, y: virus.frame.origin.y + 1, width: virus.frame.size.width, height: virus.frame.size.height)
        }
    }

    func saveRecord() {
        let today = NSDate()
        let dateString = dateFormatter.string(from: today as Date)
        UserDefaults.standard.set("User: \(userName), Score: \(score), Date: \(dateString)", forKey: "userRecord")
    }

    func choosenUserSettings() {
        if UserDefaults.standard.value(forKey: "userSettings") != nil {
            if let data = UserDefaults.standard.value(forKey: "userSettings") as? Data {
                do {
                    let userSettings = try JSONDecoder().decode(UserData.self, from: data)
                    self.userData = userSettings
                } catch {
                    print(error)
                    userData = UserData(selectedMobile: "", selectedVirus: "", userName: "")
                }
            } else {
                userData = UserData(selectedMobile: "", selectedVirus: "", userName: "")
            }
            choosenMobile = self.userData?.selectedMobile ?? ""
            choosenVirus = self.userData?.selectedVirus ?? ""
            userName = self.userData?.userName ?? ""
            userNameLabel.text = "\(userName)"
        } else {
            userData = UserData(selectedMobile: "ic_mobile_blue", selectedVirus: "ic_virus_red", userName: "User 1")
            choosenMobile = self.userData?.selectedMobile ?? ""
            choosenVirus = self.userData?.selectedVirus ?? ""
            userName = self.userData?.userName ?? ""
            userNameLabel.text = "Player: \(userName)"
        }
    }
}
