//
//  ViewController.swift
//  MVVM-C
//
//  Created by Dong on 2023/4/27.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Variables
    private let viewModel: ViewModel
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
