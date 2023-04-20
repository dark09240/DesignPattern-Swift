//
//  ViewModel.swift
//  MVVM
//
//  Created by Dong on 2023/4/19.
//

import Foundation
import DesignPattern_Swift

class ViewModel {
    
    var userListDidChange: ((ViewModel) -> Void)?
    var requestDidFail: ((ViewModel, String) -> Void)?
    
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
            requestDidFail?(self, error.message)
        }else if let data = response.data {
            userList = data
            userListDidChange?(self)
        }else {
            requestDidFail?(self, "Failed to request.")
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
