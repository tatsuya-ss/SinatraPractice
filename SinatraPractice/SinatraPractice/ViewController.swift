//
//  ViewController.swift
//  SinatraPractice
//
//  Created by 坂本龍哉 on 2021/10/09.
//

import UIKit

enum FetchError: Error {
    case urlError
    case responseError
}

struct Prefectures: Decodable {
    var prefectures: [String]
}

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var prefectures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchPrefectures { [weak self] result in
            switch result {
            case .success(let prefectures):
                self?.prefectures = prefectures.prefectures
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(PrefecturesTableViewCell.nib,
                           forCellReuseIdentifier: PrefecturesTableViewCell.identifier)
    }
    
    private func fetchPrefectures(completion: @escaping (Result<Prefectures, Error>) -> Void) {
        let localhostURLString = "http://localhost:4567/prefectures"
        guard let url = URL(string: localhostURLString) else {
            completion(.failure(FetchError.urlError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                completion(.failure(FetchError.responseError))
                return
            }
            do {
                let data = try JSONDecoder().decode(Prefectures.self, from: data)
                completion(.success(data))
            } catch {
                print(error)
            }
        }
        task.resume()
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

