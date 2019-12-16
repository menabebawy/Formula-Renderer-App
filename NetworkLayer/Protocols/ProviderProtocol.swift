//
//  ProviderProtocol.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 06/09/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

protocol ProviderProtocol {
    func request(service: ServiceProtocol, completion: @escaping (NetworkResponse) -> Void)
}
