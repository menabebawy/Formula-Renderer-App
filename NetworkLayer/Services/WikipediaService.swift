//
//  WikipediaService.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 06/09/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Foundation

public enum WikipediaService: ServiceProtocol {

    case check(formula: String)
    case render(hash: String)

    public var baseURL: URL {
        return URL(string: "https://en.wikipedia.org/api/rest_v1/media/math/")!
    }

    public var path: String {
        switch self {
        case .check:
            return "check/tex"
        case .render(let hash):
            return "render/png/\(hash)"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .check:
            return .post
        case .render:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .check(let formula):
            let parameters: [String: Any] = ["q": formula]
            return .requestParameters(parameters)
        case .render:
            return .requestPlain
        }
    }

    public var headers: Headers? {
        return ["Content-Type": "application/json", "Accept": "*/*","Cache-Control": "no-cache"]
    }

    public var parametersEncoding: ParametersEncoding {
        switch self {
        case .check:
            return .json
        case .render:
            return .url
        }
    }

}
