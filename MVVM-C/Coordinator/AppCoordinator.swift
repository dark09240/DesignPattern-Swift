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
        let viewModel = ViewModel()
        vc = ViewController(viewModel: viewModel)
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
