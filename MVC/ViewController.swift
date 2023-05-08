//
//  ViewController.swift
//  MVC
//
//  Created by Dong on 2023/4/20.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    
    private var userList: [User] = []
    private let cellIdentifier = "TableViewCell"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        reloadData()
    }

    //MARK: - Functions
    @objc private func reloadData() {
        tableView.isHidden = true
        let size: Int = .random(in: 5...20)
        let urlString = "\(APIURL.random_user_data)?size=\(size)"
        
        APIService.request(with: [User].self, url: urlString, method: .get, completionHandler: {response in
            DispatchQueue.main.async {[weak self] in
                self?.requestHandler(response)
            }
        })
    }
    
    private func requestHandler(_ response: APIService.Response<[User]>) {
        if let error = response.error {
            showAlert(with: error.message)
        }else if let data = response.data {
            userList = data
            tableView.reloadData()
            tableView.isHidden = false
        }else {
            showAlert(with: "Failed to request.")
        }
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        let reloadBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        navigationItem.rightBarButtonItem = reloadBtn
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - UITableView Data Source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let user = userList[indexPath.row]
        cell.textLabel?.text = user.username
        cell.separatorInset = .zero
        return cell
    }
}

//MARK: - UITableView Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index >= 0 && index < userList.count {
            let vc = DetailVC(user: userList[index])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
