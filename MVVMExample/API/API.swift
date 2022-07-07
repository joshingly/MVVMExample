//
//  API.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 7/7/22.
//

import Foundation
import PromiseKit

struct APIResponse {
  let raw: HTTPURLResponse
  let data: String
}

enum APIError: Error {
  case generic
  case body
  case request
  case server
}

enum HTTPMethod: String {
  case get
  case post
  case patch
  case put
  case delete
}

enum API {
  static let url = "https://jsonplaceholder.typicode.com"
  static var session: URLSession = {
    let c = URLSession.shared.configuration

    c.timeoutIntervalForRequest = 15.0

    return URLSession(configuration: c)
  }()

  static func fire(_ request: APIRequest) -> Promise<APIResponse> {
    Promise<APIResponse> { seal in
      session.dataTask(with: request.object) { data, response, error in
        guard let error = error else {
          if let data = data {
            guard let httpResponse = response as? HTTPURLResponse else {
              return seal.reject(APIError.generic)
            }

            guard let dataString = String(data: data, encoding: .utf8) else {
              return seal.reject(APIError.body)
            }

            switch httpResponse.statusCode {
            case 400 ... 499: return seal.reject(APIError.request)
            case 500 ... 599: return seal.reject(APIError.server)
            default: return seal.fulfill(APIResponse(raw: httpResponse, data: dataString))
            }

          } else {
            return seal.reject(APIError.body)
          }
        }

        seal.reject(error)
      }.resume()
    }
  }
}
