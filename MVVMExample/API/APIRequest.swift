//
//  APIRequest.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 7/7/22.
//

import Foundation

struct APIRequest {
  var object: URLRequest

  var body: String = "" { didSet {
    object.httpBody = body.data(using: .utf8)
  }}

  init(
    _ method: HTTPMethod,
    path: String,
    headers: [APIHeader] = [APIHeader](),
    parameters: [String: String] = [String: String]()
  ) {
    let base = URL(string: API.url)!.appendingPathComponent(path)

    self.object = URLRequest(url: APIRequest.url(from: base, with: parameters))
    self.object.httpMethod = method.rawValue
    self.object.httpBody = body.data(using: .utf8)

    for header in headers {
      self.object.addValue(header.value(), forHTTPHeaderField: header.key())
    }
  }

  private static func url(from url: URL, with parameters: [String: String]) -> URL {
    let components = NSURLComponents(
      url: url,
      resolvingAgainstBaseURL: false
    )!

    var queryItems = [URLQueryItem]()

    for (key, value) in parameters { queryItems.append(URLQueryItem(name: key, value: value)) }

    if !queryItems.isEmpty { components.queryItems = queryItems }

    return components.url!
  }
}
