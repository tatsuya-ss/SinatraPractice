//
//  ViewController.swift
//  SinatraPractice
//
//  Created by 坂本龍哉 on 2021/10/09.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var prefectures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(PrefecturesTableViewCell.nib,
                           forCellReuseIdentifier: PrefecturesTableViewCell.identifier)
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        prefectures.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrefecturesTableViewCell.identifier,
                                                       for: indexPath) as? PrefecturesTableViewCell
        else { fatalError("セルが見つかりません") }
        cell.configure(name: prefectures[indexPath.row])
        return cell
    }
        
}

