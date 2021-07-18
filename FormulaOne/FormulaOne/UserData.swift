//
//  UserData.swift
//  FormulaOne
//
//  Created by Anton Pogorelov on 23.04.2021.
//

import UIKit

struct UserData: Codable {
    var selectedMobile: String
    var selectedVirus: String
    var userName: String

    init (selectedMobile: String, selectedVirus: String, userName: String) {
        self.selectedMobile = selectedMobile
        self.selectedVirus = selectedVirus
        self.userName = userName
    }
}
