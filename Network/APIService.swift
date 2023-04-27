
import Foundation

public class APIService {
    
    public typealias Response<T> = (data: T?, error: APIError?)
    
    public enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    public static let timeout: TimeInterval = 5
    
    public static func request<T: Codable>(with type: T.Type, url urlString: String, method: HttpMethod, completionHandler: @escaping (Response<T>) -> Void) {
        guard let url = URL(string: urlString) else {
            let error = APIError(message: "Failed to load url.")
            completionHandler((nil, error))
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: APIService.timeout)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            if let error {
                let apiError = APIError(message: error.localizedDescription, error: error)
                completionHandler((nil, apiError))
            }else if let data {
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completionHandler((result, nil))
                }catch {
                    let apiError = APIError(message: error.localizedDescription, error: error)
                    completionHandler((nil, apiError))
                }
            }else {
                let apiError = APIError(message: "Failed to request.")
                completionHandler((nil, apiError))
            }
        }).resume()
    }
}
