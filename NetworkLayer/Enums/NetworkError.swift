//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 06/09/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

public enum NetworkError: Error {
    case noJSONData
    case unknown
    case description(String)
}
