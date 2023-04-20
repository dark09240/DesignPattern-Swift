//
//  Presenter.swift
//  MVP
//
//  Created by Dong on 2023/4/19.
//

import Foundation
import DesignPattern_Swift

protocol PresenterDelegate: AnyObject {
    func presenterReloadDataSuccess()
    func presenterReloadDataFail(with message: String)
}

class Presenter {
    
    weak var delegate: PresenterDelegate?
    
    var numberOfUserList: Int {
        return userList.count
    }
    
    private var userList: [User] = []
    
    func reloadData() {
        DesignPatternFramework.requestUseList(completionHandler: {response in
            DispatchQueue.main.async {[weak self] in
                self?.requestHandler(response)
            }
        })
    }
    
    private func requestHandler(_ response: APIService.Response<[User]>) {
        if let error = response.error {
            delegate?.presenterReloadDataFail(with: error.message)
        }else if let data = response.data {
            userList = data
            delegate?.presenterReloadDataSuccess()
        }else {
            delegate?.presenterReloadDataFail(with: "Failed to request.")
        }
    }
    
    func userAtIndex(_ index: Int) -> User? {
        if index >= 0, index < userList.count {
            return userList[index]
        }else {
            return nil
        }
    }
}
