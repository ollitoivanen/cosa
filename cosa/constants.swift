/*import UIKit
import Foundation
import SwiftUI

struct Album: Codable, Identifiable {
    var id: UUID
    var dateCreated: Date
    var name: String
    var pages: [Page]

    init(id: UUID = UUID(), dateCreated: Date = Date(), name: String, pages: [Page] = []){
        self.id = id
        self.dateCreated = dateCreated
        self.name = name
        self.pages = pages
     }
}

extension Album {
    struct Data {
            var name: String = ""
            var dateCreated: Date = Date()
            var pages: [Page] = [Page(elements: [])]
        }

        var data: Data {
            Data(name: name, dateCreated: dateCreated, pages: pages)
        }

    //This init is used when creating a new album
    init(data: Data) {
            id = UUID()
            name = data.name
            dateCreated = data.dateCreated
            pages = data.pages
        }
}

struct Page: Codable, Identifiable {
    var id: UUID
    var elements: [Element]

    init(id: UUID = UUID(), elements: [Element]){
        self.id = id
        self.elements = elements
    }
}


enum ElementType: String, Codable {
    case photo
    case message
}
class Element: Codable, Identifiable {
    var id: UUID
    var type: ElementType
    var content: String
    var position: CGPoint
    var width: CGFloat
    var rotation: CGFloat

    var image: Image {
        return AlbumManager().getImageElement(imageUrl: content)
    }

    init(id: UUID, type: ElementType, content:String, position: CGPoint, width: CGFloat, rotation: CGFloat){
        self.id = id
        self.type = type
        self.content = content
        self.position = position
        self.width = width
        self.rotation = rotation
    }
}

let FRAME_WIDTH = 1080
let FRAME_HEIGHT = 1920
//Tried to created protocol, but as Element got nested inside Page and Album, things broke.
//Not enough understanding
/*protocol Element: Codable, Identifiable {
    var id: UUID {get set}
    var date: Date {get set}
    var position: CGPoint {get set}
    var width: CGFloat {get set}
    var rotation: CGFloat {get set}
}

struct PhotoElement: Element, Codable {
    var id: UUID
    var date: Date
    var position: CGPoint
    var width: CGFloat
    var rotation: CGFloat
    var URL: URL

    init(id: UUID = UUID(), date: Date, position: CGPoint, width: CGFloat, rotation: CGFloat, URL:URL){
        self.id = id
        self.date = date
        self.position = position
        self.width = width
        self.rotation = rotation
        self.URL = URL
    }
}

struct MessageElement: Element, Codable {
    var id: UUID
    var date: Date
    var position: CGPoint
    var width: CGFloat
    var rotation: CGFloat
    var content: String

    init(id: UUID = UUID(), date: Date, position: CGPoint, width: CGFloat, rotation: CGFloat, content:String){
        self.id = id
        self.date = date
        self.position = position
        self.width = width
        self.rotation = rotation
        self.content = content
    }}
*/

*/
