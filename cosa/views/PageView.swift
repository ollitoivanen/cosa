//
//  PageView.swift
//  cosa
//
//  Created by Olli Toivanen on 30.8.2022.
//

import Foundation
import SwiftUI

struct PageView: View {
    @Environment(\.managedObjectContext) var moc

    @State var page: Page
    @State var elements: [Element]?

    @Binding var editMode: Bool

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
    var body: some View{
        ZStack{
            ///Only images in MVP
            ForEach(elements ?? [], id: \.id){ element in
               /* ElementViewController(img: UIImage(data:element.image!)!)*/
                //PhotoElementView(element: element)
            }
        }.onAppear{
            elements = fetchElements()
        }.aspectRatio(9/16, contentMode: .fit)
            //.border(editMode ? , :  lineWidth: editMode ? 2 : 0)
    }
}

/*   @ViewBuilder
   var renderedView: some View {
       if elementImages == [] {
           ProgressView().task {
               AlbumStore.loadImages(elements: page.elements){result in
                   switch result {
                   case .failure(let error):
                       print(error.localizedDescription)
                   case .success(let images):
                       elementImages = images
               }
               }
           }
       }else {
           GeometryReader { geometry in
               self.makeView(geometry, page: $page)
           }
           .tag(page.id)
           .aspectRatio(9/16, contentMode: .fit)
           .clipped()
       }
   }

   func makeView(_ geometry: GeometryProxy, page: Binding<Page>) -> some View {
          return ZStack{
              //Loaded images should be integrated into the same array with the original elements to prevent fuckups index changes
              ForEach(page.elements, id: \.id){ $element in
                  PhotoElementView(element: $element, image: elementImages[page.elements.firstIndex(where: element)!] frame: geometry.frame(in: .local).size, editMode: $editMode)
              }
          }
      }*/
