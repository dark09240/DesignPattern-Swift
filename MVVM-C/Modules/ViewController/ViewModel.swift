//
//  ViewModel.swift
//  MVVM-C
//
//  Created by Dong on 2023/4/26.
//

import UIKit

class ViewModel: NSObject {
    //MARK: - Variables
    let navigator: Navigator
    
    var userListDidChange: ((ViewModel) -> Void)?
    var requestDidFail: ((ViewModel, String) -> Void)?
    
    var numberOfUserList: Int {
        return userList.count
    }
    
    private var userList: [User] = []
    
    //MARK: - Functions
    func reloadData() {
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
    
    //MARK: - Init
    init(navigator: Navigator) {
        self.navigator = navigator
        super.init()
    }
}

//MARK: - UITableView Delegate
extension ViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index >= 0, index < userList.count {
            navigator.pushToDetail(with: userList[index])
        }
    }
}
