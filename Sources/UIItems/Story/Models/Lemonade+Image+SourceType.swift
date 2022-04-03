//
//  Lemonade+Image+SourceType.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 7.03.2022.
//

public enum ImageSourceType {
    case fromUrl(path: String)
    case fromName(name: String)
        
    public func image(complitionHandler: @escaping (UIImage?)-> Void) {
        switch self {
        case .fromName(let name): complitionHandler(UIImage(named: name))
        case .fromUrl(let path):
            guard let url = URL(string: path) else {
                complitionHandler(nil)
                return
            }
            let task = URLSession.shared
                .dataTask(with: url) { data, response, err in
                    guard let data = data, err == nil else { return }
                    complitionHandler(UIImage(data: data))
                }
            task.resume()
        }
    }
    
}
