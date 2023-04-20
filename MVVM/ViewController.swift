//
//  ViewController.swift
//  MVVM
//
//  Created by Dong on 2023/4/20.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ViewModel()
    private let cellIdentifier = "TableViewCell"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewModel()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    //MARK: - Functions
    @objc private func reloadData() {
        tableView.isHidden = true
        viewModel.reloadData()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        let reloadBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        navigationItem.rightBarButtonItem = reloadBtn
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

//MARK: - UITableView Data Source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUserList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let user = viewModel.userAtIndex(indexPath.row) else {
            return cell
        }
        cell.textLabel?.text = user.last_name + " " + user.first_name
        cell.separatorInset = .zero
        return cell
    }
}

//MARK: - ViewModel
extension ViewController {
    private func buildViewModel() {
        viewModel.userListDidChange = {[weak self] _ in
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
        }
    }
}
