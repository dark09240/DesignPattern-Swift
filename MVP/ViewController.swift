//
//  ViewController.swift
//  MVP
//
//  Created by Dong on 2023/4/20.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = Presenter()
    private let cellIdentifier = "TableViewCell"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupViews()
        reloadData()
    }
    
    //MARK: - Functions
    @objc private func reloadData() {
        tableView.isHidden = true
        presenter.reloadData()
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
        return presenter.numberOfUserList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let user = presenter.userAtIndex(indexPath.row) else {
            return cell
        }
        cell.textLabel?.text = user.username
        cell.separatorInset = .zero
        return cell
    }
}

//MARK: - UITableView Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = presenter.userAtIndex(indexPath.row) else {
            return
        }
        let vc = DetailVC(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Presenter Delegate
extension ViewController: PresenterDelegate {
    func presenterReloadDataSuccess() {
        tableView.reloadData()
        tableView.isHidden = false
    }
    
    func presenterReloadDataFail(with message: String) {
        showAlert(with: message)
    }
}
