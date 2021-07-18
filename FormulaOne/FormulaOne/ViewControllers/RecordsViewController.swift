//
//  RecordsViewController.swift
//  FormulaOne
//
//  Created by Anton Pogorelov on 23.04.2021.
//

import UIKit

class RecordsViewController: UIViewController {
    // MARK: - Properties
    var userArray = UserDefaults.standard.object(forKey: "lastRecord") as? [String] ?? [String]()

    // MARK: - IBOutlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var recordsTableView: UITableView!

    // MARK: - Lifestyle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        recordsTableView.delegate = self
        recordsTableView.dataSource = self

        backButton.addShadow(color: .gray, radius: 7, offset: .zero, opacity: 0.5)
        clearButton.addShadow(color: .gray, radius: 7, offset: .zero, opacity: 0.5)

        backButton.addCornerRadius(cornerRadius: 20)
        clearButton.addCornerRadius(cornerRadius: 20)
    }

    // MARK: - IBActions
    @IBAction private func onBackButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Extensions
extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = userArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
}
