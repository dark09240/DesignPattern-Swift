//
//  DesignPatternFramework.swift
//  DesignPattern-Swift
//
//  Created by Dong on 2023/4/20.
//

import Foundation

public class DesignPatternFramework {
    
    public static func requestUseList(completionHandler: @escaping (APIService.Response<[User]>) -> Void) {
        let size: Int = .random(in: 5...20)
        let urlString = "\(APIURL.random_user_data)?size=\(size)"
        
        APIService.request(with: [User].self, url: urlString, method: .get, completionHandler: completionHandler)
    }
}
 
