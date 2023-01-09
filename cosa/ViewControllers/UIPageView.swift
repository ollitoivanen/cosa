//
//  PageViewControllerRepresentable.swift
//  cosa
//
//  Created by Olli Toivanen on 23.11.2022.
//

import SwiftUI

struct UIPageView: UIViewControllerRepresentable {
    typealias UIViewControllerType = PageViewController
    @Environment(\.managedObjectContext) var moc

    var page: Page
    
    func fetchElements() -> [Element]{
        let request = Element.fetchRequest()
          request.predicate = NSPredicate(format: "page = %@", page)
          request.sortDescriptors = []
          var fetchedElements: [Element] = []
          do {
            fetchedElements = try moc.fetch(request)
          } catch let error {
            print("Error fetching songs \(error)")
          }
        return fetchedElements

    }
    func makeUIViewController(context: Context) -> PageViewController {
        
            let pageViewController = PageViewController(fetchElements())

            return pageViewController
            // Return MyViewController instance
        }

        func updateUIViewController(_ uiViewController: PageViewController, context: Context){
            // Updates the state of the specified view controller with new information from SwiftUI.
        }
}
