//
//  ViewController.swift
//  ResultType
//
//  Created by RakeshPC on 28/06/19.
//  Copyright © 2019 RakeshPC. All rights reserved.
//

import UIKit


public struct Uesrs: Codable {
    
    public var completed : Bool!
    public var id : Int!
    public var title : String!
    public var userId : Int!
    
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.fetchUsers { (uesrs, err) in
        //            if let error = err {
        //                print("Failed to fetch users:", error)
        //                return
        //            }
        //
        //            uesrs?.forEach({(uesrs) in
        //                print(uesrs.title!)
        //            })
        //        }
        
        
        self.fetchUsers { (res) in
            switch res {
            case .success(let users):
                users.forEach({(users) in
                    print(users.userId!)
                })
            case .failure(let err):
                print("Failed to fetch users: ", err)
            }
        }
        
    }
    
    fileprivate func fetchUsers(completion:@escaping (Result<[Uesrs], Error>) -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/todos"
        
        guard  let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            do {
                let user = try JSONDecoder().decode([Uesrs].self, from: data!)
                completion(.success(user))
            }catch let error {
                completion(.failure(error))
            }
            }.resume()
    }
}

