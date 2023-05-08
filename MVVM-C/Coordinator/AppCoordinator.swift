//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by Dong on 2023/4/26.
//

import UIKit

class AppCoordinator: Coordinator {
    
    //MARK: - Variables
    private let window: UIWindow
    private var vc: ViewController?
    
    //MARK: - Init
    init(window: UIWindow) {
        self.window = window
    }
    
    //MARK: - Functions
    func start() {
        let viewModel = ViewModel(navigator: self)
        vc = ViewController(viewModel: viewModel)
        let nc = UINavigationController(rootViewController: vc!)
        window.rootViewController = nc
        window.makeKeyAndVisible()
    }
}

//MARK: - Navigator
extension AppCoordinator: Navigator {
    func pushToDetail(with user: User) {
        let detailVC = DetailVC(user: user)
        vc?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
