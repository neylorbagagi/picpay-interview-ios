//
//  ListContactsDataProviding.swift
//  Interview
//
//  Created by Neylor Bagagi on 13/07/25.
//

import Foundation
import Combine

protocol ListContactsDataProviding {
    var dataModel: AnyPublisher<ListContactsDataModel, Never> { get }
    func getListContactsData()
}

final class ListContactsDataProvider: ListContactsDataProviding {
    
// TODO: Add Error Handling
    var dataModel: AnyPublisher<ListContactsDataModel, Never> {
        return dataModelSubject.eraseToAnyPublisher()
    }
    
    private let session: URLSessionProtocol
    private let dataModelSubject = PassthroughSubject<ListContactsDataModel, Never>()
    private let apiURL = "https://669ff1b9b132e2c136ffa741.mockapi.io/picpay/ios/interview/contacts"
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func getListContactsData() {
        guard let api = URL(string: apiURL) else {
            dataModelSubject.send(ListContactsDataModel.emptyDataModel())
            return
        }
        
        session.dataTask(with: api) { [weak self] (data, response, error) in
            guard let jsonData = data else {
                self?.dataModelSubject.send(ListContactsDataModel.emptyDataModel())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([ContactDataModel].self, from: jsonData)
                self?.dataModelSubject.send(ListContactsDataModel(contacts: decoded))
            } catch _ {
                self?.dataModelSubject.send(ListContactsDataModel.emptyDataModel())
            }
        }.resume()
    }
}

// TODO: Move this to a separate Networking module
protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        // Just return the real data task
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask)
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    func resume() {
        closure()
    }
}

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return MockURLSessionDataTask {
            completionHandler(self.data, nil, self.error)
        }
    }
}


/**
 protocol ListContactServiceProtocol {
     func fetchContacts(completion: @escaping ([Contact]?, Error?) -> Void)
 }

 class ListContactService: ListContactServiceProtocol {
     private let session: URLSessionProtocol
     
     init(session: URLSessionProtocol = URLSession.shared) {
         self.session = session
     }
     
     func fetchContacts(completion: @escaping ([Contact]?, Error?) -> Void) {
         guard let api = URL(string: apiURL) else {
             return
         }
         
         let task = session.dataTask(with: api) { (data, response, error) in
             guard let jsonData = data else {
                 completion(nil, error)
                 return
             }
             
             do {
                 let decoder = JSONDecoder()
                 let decoded = try decoder.decode([Contact].self, from: jsonData)
                 
                 completion(decoded, nil)
             } catch let error {
                 completion(nil, error)
             }
         }
         
         task.resume()
     }
 }
 */
