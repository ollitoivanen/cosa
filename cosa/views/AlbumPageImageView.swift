import SwiftUI

struct AlbumPageImageView: View{
    var albumManager = AlbumManager()
    var albumId: String
    var pageId: String
    var elementId: String
    
    @Binding var selectedElement: String?
    @Binding var editable: Bool
    
    @State private var prevTranslation: CGSize = CGSize(width: 0, height: 0)
    @State private var tempTranslation: CGPoint = CGPoint(x:0, y:0)
    @State private var tempScale: CGFloat = 1
    @State private var tempRotation: CGFloat = 0
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    let frame: CGRect
    
   /* func element() -> Element {
        let albumIndex = ads.albumsData.firstIndex(where: {$0.id == albumId})!
         let pageIndex = ads.albumsData[albumIndex].pages.firstIndex(where: {$0.id == pageId})!
         let elementIndex = ads.albumsData[albumIndex].pages[pageIndex].elements.firstIndex(where: {$0.id == elementId})!
        return ads.albumsData[albumIndex].pages[pageIndex].elements[elementIndex]
    }
    
    var movableImage: some View{
        
        Image("placeholder")
            .resizable()
            .scaledToFit()
            .frame(width: element().width/1080 * frame.width * tempScale)
            .padding(2)
            .overlay(Rectangle().stroke(.black, lineWidth: 2))
            .rotationEffect(.degrees(element().rotation + tempRotation))
            .position(location)
            //.position(x:element().position.x/1080*frame.width + tempTranslation.x, y: element().position.y/1920*frame.height + tempTranslation.y)
            //.gesture(elementMovement)
            .gesture(
                            simpleDrag
                        )
            .onAppear(perform: {
            })
    }
    
    var immovableImage: some View{
        Image("placeholder")
            .resizable()
            .scaledToFit()
            .frame(width: element().width/1080 * frame.width * tempScale)
            .padding(2)
            .rotationEffect(.degrees(element().rotation + tempRotation))
            .position(x:element().position.x/1080*frame.width, y: element().position.y/1920*frame.height)
        
    }
    
    var elementMovement: some Gesture{
        SimultaneousGesture(dragGesture, elementTranslation).onEnded({value in
        })
    }
    
    var elementTranslation: some Gesture{
        SimultaneousGesture(scaleGesture, rotationGesture).onEnded({value in
        })
    }

    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                       self.location = value.location
                   }
    }
    
    var scaleGesture: some Gesture {
        MagnificationGesture().onChanged({ scale in
          
            self.tempScale = scale}).onEnded({scale in
                print("END scale")
                
                let albumsData = ads.albumsData
                let albumIndex = albumsData.firstIndex(where: {$0.id == albumId})!
                let pageIndex = albumsData[albumIndex].pages.firstIndex(where: {$0.id == pageId})!
                let elementIndex = albumsData[albumIndex].pages[pageIndex].elements.firstIndex(where: {$0.id == element().id})!
                ads.albumsData[albumIndex].pages[pageIndex].elements[elementIndex].width = element().width * scale
                self.tempScale = 1
                
            })
    }
    
    
    
    var rotationGesture: some Gesture {
        RotationGesture().onChanged({rotation in
            if(rotation.degrees > 5 || rotation.degrees < (-5)){
                tempRotation = rotation.degrees
                
            }else{
                tempRotation = 0
            }
        }).onEnded({ rotation in
            print("END rotation")
            
            let albumsData = ads.albumsData
            let albumIndex = albumsData.firstIndex(where: {$0.id == albumId})!
            let pageIndex = albumsData[albumIndex].pages.firstIndex(where: {$0.id == pageId})!
            let elementIndex = albumsData[albumIndex].pages[pageIndex].elements.firstIndex(where: {$0.id == element().id})!
            ads.albumsData[albumIndex].pages[pageIndex].elements[elementIndex].rotation += rotation.degrees
            tempRotation = 0
        })
    }
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let newLocation = CGPoint(x:element().position.x / 1080 * frame.width + value.translation.width - prevTranslation.width, y: element().position.y / 1920 * frame.height + value.translation.height - prevTranslation.height)
                
                if(newLocation.y <= frame.minY || newLocation.y >= frame.maxY){
                    self.tempTranslation.x = value.translation.width
                    self.prevTranslation = value.translation
                }else if(newLocation.x <= frame.minX || newLocation.x >= frame.maxX){
                    self.tempTranslation.y = value.translation.height
                    self.prevTranslation = value.translation
                }else{
                    self.tempTranslation = CGPoint(x:value.translation.width, y:value.translation.height)
                    
                    self.prevTranslation = value.translation
                    
                }
            }
            .onEnded{ value in
                print("END move")
                let albumsData = ads.albumsData
                let albumIndex = albumsData.firstIndex(where: {$0.id == albumId})!
                let pageIndex = albumsData[albumIndex].pages.firstIndex(where: {$0.id == pageId})!
                let elementIndex = albumsData[albumIndex].pages[pageIndex].elements.firstIndex(where: {$0.id == element().id})!
                ads.albumsData[albumIndex].pages[pageIndex].elements[elementIndex].position.x += value.translation.width / frame.width * 1080
                ads.albumsData[albumIndex].pages[pageIndex].elements[elementIndex].position.y += value.translation.height / frame.height * 1920
                self.tempTranslation = CGPoint(x:0, y:0)
                prevTranslation = CGSize(width: 0, height: 0)
            }
        
        
        
    }
    
    */
    var body: some View {
        ZStack{
           /* if(selectedElement == element().id && editable){
                movableImage
            }else{
                immovableImage
                
            }*/
        }.onAppear(perform: {
        })
        
        
    }
}
