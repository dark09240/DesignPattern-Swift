//
//  DetailVC.swift
//  MVC
//
//  Created by Dong on 2023/5/8.
//

import UIKit

class DetailVC: UIViewController {
    //MARK: - Variables
    let user: User
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        title = user.username
        setupAvatarView()
        firstNameLabel.text = user.first_name
        lastNameLabel.text = user.last_name
    }
    
    private func setupAvatarView() {
        guard let url = URL(string: user.avatar) else {
            return
        }
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let data, let image = UIImage(data: data) {
                DispatchQueue.main.async {[weak self] in
                    self?.avatarImageView.image = image
                    self?.avatarImageView.isHidden = false
                }
            }
        }.resume()
    }
    
    //MARK: - Init
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
