//
//  SettingsViewController.swift
//  FormulaOne
//
//  Created by Anton Pogorelov on 23.04.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: - Properties
    private var userName = ""
    private var selectedMobile = ""
    private var selectedVirus = ""
    private let userMobiles = ["ic_mobile_blue", "ic_mobile_black", "ic_mobile_yellow"]
    private let userViruses = ["ic_virus_red", "ic_virus_black", "ic_virus_pink"]
    var userData: UserData!

    // MARK: - IBOutlets
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var choosenMobile: UIImageView!
    @IBOutlet private weak var choosenVirus: UIImageView!
    @IBOutlet private weak var blueMobileButton: UIButton!
    @IBOutlet private weak var blackMobileButton: UIButton!
    @IBOutlet private weak var yellowMobileButton: UIButton!
    @IBOutlet private weak var redVirusButton: UIButton!
    @IBOutlet private weak var blackVirusButton: UIButton!
    @IBOutlet private weak var pinkVirusButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!

    // MARK: - Lifestyle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        blueMobileButton.addShadow(color: .gray, radius: 5, offset: .zero, opacity: 0.5)
        blackMobileButton.addShadow(color: .gray, radius: 5, offset: .zero, opacity: 0.5)
        yellowMobileButton.addShadow(color: .gray, radius: 5, offset: .zero, opacity: 0.5)
        redVirusButton.addShadow(color: .gray, radius: 5, offset: .zero, opacity: 0.5)
        blackVirusButton.addShadow(color: .gray, radius: 5, offset: .zero, opacity: 0.5)
        pinkVirusButton.addShadow(color: .gray, radius: 5, offset: .zero, opacity: 0.5)
        saveButton.addShadow(color: .gray, radius: 5, offset: .zero, opacity: 0.5)
        backButton.addShadow(color: .gray, radius: 5, offset: .zero, opacity: 0.5)

        blueMobileButton.addCornerRadius(cornerRadius: 15)
        blackMobileButton.addCornerRadius(cornerRadius: 15)
        yellowMobileButton.addCornerRadius(cornerRadius: 15)
        redVirusButton.addCornerRadius(cornerRadius: 15)
        blackVirusButton.addCornerRadius(cornerRadius: 15)
        pinkVirusButton.addCornerRadius(cornerRadius: 15)
        saveButton.addCornerRadius(cornerRadius: 35)
        backButton.addCornerRadius(cornerRadius: 20)

        userData = UserData(selectedMobile: "", selectedVirus: "", userName: "User 1")
        loadUserSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        choosenMobile.image = UIImage(named: "ic_mobile_black")
        choosenVirus.image = UIImage(named: "ic_virus_black")
    }

    // MARK: - IBAction
    @IBAction private func onBlueMobileButton(_ sender: UIButton) {
        choosenMobile.image = UIImage(named: "ic_mobile_blue")
        selectedMobile = userMobiles[0]
    }

    @IBAction private func onBlackMobileButton(_ sender: UIButton) {
        choosenMobile.image = UIImage(named: "ic_mobile_black")
        selectedMobile = userMobiles[1]
    }

    @IBAction private func onYellowMobileButton(_ sender: UIButton) {
        choosenMobile.image = UIImage(named: "ic_mobile_yellow")
        selectedMobile = userMobiles[2]
    }

    @IBAction private func onRedVirusButton(_ sender: UIButton) {
        choosenVirus.image = UIImage(named: "ic_virus_red")
        selectedVirus = userViruses[0]
    }

    @IBAction private func onBlackVirusButton(_ sender: UIButton) {
        choosenVirus.image = UIImage(named: "ic_virus_black")
        selectedVirus = userViruses[1]
    }

    @IBAction private func onPinkVirusButton(_ sender: UIButton) {
        choosenVirus.image = UIImage(named: "ic_virus_pink")
        selectedVirus = userViruses[2]
    }

    @IBAction private func onBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func onSaveButton(_ sender: Any) {
        if nameTextField.text != "" {
            self.userData.userName = nameTextField.text ?? ""
        } else {
            nameTextField.text = "User 1"
        }
        self.userData.selectedMobile = selectedMobile
        self.userData.selectedVirus = selectedVirus
        do {
        let data = try JSONEncoder().encode(userData)
        UserDefaults.standard.setValue(data, forKey: "userSettings")
        } catch {
            print(error)
        }
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Others Functions
    func loadUserSettings() {
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
            selectedMobile = self.userData?.selectedMobile ?? ""
            selectedVirus = self.userData?.selectedVirus ?? ""
            userName = self.userData?.userName ?? ""
            nameTextField.text = "\(userName)"
        }
    }
}
