//
//  BackendController.swift
//  Code
//
//  Created by Henk van der Spek on 10/05/2022.
//

import Foundation

enum Backend {
    struct Images: Decodable {
        struct Item: Decodable, Identifiable {
            let id = UUID()
            let width: Int
            let height: Int
            let regular: String
            let thumb: String
        }
        let items: [Item]
    }
}

protocol BackendControlling {
    func fetchImages(_ query: String, count: Int) async -> Backend.Images?
}

class BackendController: ObservableObject {
    enum Configuration {
        case dev
        case live
    }
    let configuration: Configuration
    let session: URLSession
    init(configuration c: Configuration, urlSession s: URLSession = .shared) {
        configuration = c
        session = s
    }
}

extension BackendController: BackendControlling {
    @MainActor
    func fetchImages(_ query: String, count: Int) async -> Backend.Images? {
        await createTask(.fetchImages(query: query, count: count))
    }
}

private extension BackendController {
    struct Empty: Codable {}
    enum Task {
        case fetchImages(query: String, count: Int)
    }
    func createTask<T>(_ t: Task) async -> T? where T: Decodable {
        guard let r = t.urlRequest(root: configuration.root, mock: configuration == .dev) else { return nil }
        do {
            print(String(data: r.httpBody ?? .init(), encoding: .utf8) ?? "No body")
            let (d, _) = try await session.data(for: r)
            print(String(data: d, encoding: .utf8) ?? "Empty result")
            return try decode(d)
        } catch {
            print(error)
            return nil
        }
    }
    private func decode<T>(_ d: Data) throws -> T? where T: Decodable {
        T.self == Empty.self ? Empty() as? T : try JSONDecoder().decode(T.self, from: d)
    }
}


private extension BackendController.Configuration {
    var root: String {
        switch self {
        case .dev: return "http://localhost:3000/api"
        case .live: return "https://uicorn.herokuapp.com/api"
        }
    }
}

private extension BackendController.Task {
    func urlRequest(root: String, mock: Bool) -> URLRequest? {
        guard let u = URL(string: "\(root)/\(path(mock: mock))") else { return nil }
        print(u)
        var r = URLRequest(url: u)
        r.httpMethod = method
        r.httpBody = data
        headers.forEach { r.setValue($0.value, forHTTPHeaderField: $0.key) }
        return r
    }
    private func path(mock: Bool) -> String {
        switch self {
        case let .fetchImages(q, c):
            return "images/random?query=\(q)&count=\(c)&mock=\(mock ? 1 : 0)"
        }
    }
    private var method: String {
        switch self {
        case .fetchImages:
            return "GET"
        }
    }
    private var data: Data? {
        switch self {
        case .fetchImages:
            return nil
        }
    }
    private var headers: [String: String] {
        switch self {
        case .fetchImages:
            return [:]
        }
    }
}
