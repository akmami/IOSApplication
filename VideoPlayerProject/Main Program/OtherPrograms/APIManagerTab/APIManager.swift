//
//  APIManager.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-16.
//

import Foundation
class APIManager {

    // MARK: - Public Methods
    func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HttpMethod,
                     completion: @escaping (_ result: Results) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in

            guard let request = self?.prepareRequest(withURL: url, httpMethod: httpMethod) else {
                completion(Results(withError: CustomError.failedToCreateRequest))
                return
            }
            
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: request) { (data, response, error) in
                completion(Results(withData: data,
                                   response: Response(fromURLResponse: response),
                                   error: error))
            }
            task.resume()
        }
    }
            
    func getData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else { completion(nil); return }
                completion(data)
            })
            task.resume()
        }
    }
    
    // MARK: - Private Methods
    private func prepareRequest(withURL url: URL?, httpMethod: HttpMethod) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        return request
    }
}

// MARK: - APIManager Custom Types
extension APIManager {
    
    enum HttpMethod: String {
        case get
        case post
    }
    
    // MARK: - Response from the server to the request
    struct Response {
        var response: URLResponse?
        var httpStatusCode: Int = 0
        
        init(fromURLResponse response: URLResponse?) {
            guard let response = response else { return }
            self.response = response
            httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        }
    }
    
    // MARK: - Result from request via URL for API
    struct Results {
        var data: Data?
        var response: Response?
        var error: Error?
        
        init(withData data: Data?, response: Response?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }
        
        init(withError error: Error) {
            self.error = error
        }
    }
    
    enum CustomError: Error {
        case failedToCreateRequest
    }
}

// MARK: - Custom Error Description
extension APIManager.CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
            case .failedToCreateRequest: return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        }
    }
}
