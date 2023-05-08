//
//  ViewController.swift
//  MVVM-C
//
//  Created by Dong on 2023/4/27.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: ViewModel
    private let cellIdentifier = "TableViewCell"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewModel()
        setupViews()
        reloadData()
    }
    
    //MARK: - Functions
    @objc private func reloadData() {
        tableView.isHidden = true
        viewModel.reloadData()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        title = "MVVM-C"
        
        let reloadBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        navigationItem.rightBarButtonItem = reloadBtn
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = viewModel
    }

    //MARK: - Init
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        cell.textLabel?.text = user.username
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
        
        viewModel.requestDidFail = {[weak self] _, message in
            self?.showAlert(with: message)
        }
    }
}
