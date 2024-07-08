import UIKit

enum CategoriesEnum {
    case all
    case category(name: String)
    
    var getName: String {
        switch self {
        case .all:
            return "All"
        case .category(let string):
            return string
        }
    }
}
