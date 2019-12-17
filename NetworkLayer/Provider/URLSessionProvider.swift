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
        DispatchQueue.main.async {
            guard error == nil else {
                return completion(.failure(.description(error?.localizedDescription ?? "")))
            }
            
            guard let data = data, let response = response else {
                return completion(.failure(.noJSONData))
            }
            
            switch response.statusCode {
            case 200...299:
                completion(.success(response, data))
            case 400, 404:
                guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let title = json?["title"] as? String else {
                        completion(.failure(.unknown))
                        return
                }
                completion(.failure(.description(title)))
            default:
                completion(.failure(.unknown))
            }
        }
    }

}
