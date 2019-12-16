//
//  URLSessionProvider.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 06/09/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Foundation

public final class URLSessionProvider: ProviderProtocol {
    private var session: URLSessionProtocol

    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    public func request(service: ServiceProtocol, completion: @escaping (NetworkResponse) -> Void) {
        let request = URLRequest(service: service)
        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }
    
    private func handleDataResponse(data: Data?,
                                    response: HTTPURLResponse?,
                                    error: Error?,
                                    completion: @escaping (NetworkResponse) -> Void) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }
        
        DispatchQueue.main.async {
            switch response.statusCode {
            case 200...299:
                guard let data = data else { return completion(.failure(.unknown)) }
                completion(.success(response, data))
            default:
                completion(.failure(.unknown))
            }
        }
    }

}
