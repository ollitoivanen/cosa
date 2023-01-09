import SwiftUI

struct AlbumScreen: View {

    @Environment(\.managedObjectContext) var moc


    @State var album: Album
    @State var showingToolbar = false
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage? = nil
    @State private var image: Image?
    @State var selectedPage: Page

    @State private var pages: [Page]?

    @State var editMode: Bool = false

    ///This can be done with property wrapper but the passed argument is not available before init
    func fetchPages() -> [Page]{
        let request = Page.fetchRequest()
          request.predicate = NSPredicate(format: "album = %@", album)
          request.sortDescriptors = []
          var fetchedPages: [Page] = []
          do {
            fetchedPages = try moc.fetch(request)
          } catch let error {
            print("Error fetching songs \(error)")
          }

        return fetchedPages
    }

    func loadImage() {
        guard let selectedImage = inputImage else { return }
        ///Resizes the cover image to half the size of the original. selectedImage is the one being displayed,
        ///inputImage is a state so updating it here to lwer quality would create an infinite loop.
        ///TODO disabled for MVP
        
        image = Image(uiImage: selectedImage)
        ///For test purose only save to first page

        let element = Element(context: moc)
        element.id = UUID()
        element.width = 400
        element.image = selectedImage.jpegData(compressionQuality: 1)
        element.positionX = 400
        element.positionY = 400
        ///TODO Not optimal add fetches to single file
        selectedPage.addToElements(element)

        //pages?[selectedPageIndex].addToElements(element)
        ///After loading new image, if the last page is no longer empty, create new empty last page.
        if(selectedPage == pages?.last){
            let newPage = Page(context: moc)
            newPage.id = UUID()
            ///addTo-method creates a relationship between these two
            ///instances of page and album.
            album.addToPages(newPage)
        }
        try? moc.save()
       pages = fetchPages()
        ///This isn't refreshing the pages when new image is added
    }

    func fetchElements(page: Page) -> [Element]{
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
    var body: some View {
        ///Testing testing as Skepta said
        TabView(selection: $selectedPage) {
          /*  ForEach(album.pages?.array as! [Page]){ page in
                PageView(page: page).tag(page)
            }*/

            ForEach(pages ?? []){ page in
                UIPageView(page: page)
              /*  PageView(page: page, editMode: $editMode).tag(page)*/
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .toolbar {
            ToolbarItem(placement: .confirmationAction){

                Button(action: {}) {
                    Text("Edit")

                    //Image(systemName: editable ? "pencil.circle.fill" : "pencil.circle")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){

                Button(action: {}) {
                    Image(systemName: "plus")

                    //Image(systemName: editable ? "pencil.circle.fill" : "pencil.circle")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){

                Button(action: {showingImagePicker = true}) {
                    Image(systemName: "photo")

                    //Image(systemName: editable ? "pencil.circle.fill" : "pencil.circle")
                }.sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                ///Fills the image-variable with the selected image
                .onChange(of: inputImage) {_ in loadImage()}

                }

        }.onAppear{
            pages = fetchPages()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(showingToolbar)
        .statusBar(hidden: showingToolbar)
    }
}
/*struct AlbumScreen: View {


    @Binding var album: Album
    @Environment(\.presentationMode) var presentation
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?

    @State var offset = CGSize.zero
    @State var longPressed: Bool = false

    @State var selectedPage: UUID
    @State var editMode: Bool = false


    func loadImage() {
        guard let inputImage = inputImage else { return }
        let uuid = UUID()
        let imageUrl = uuid.uuidString + ".jpg"
        saveJpg(image: inputImage, imageUrl: imageUrl)
        let newElement = Element(id: uuid, type: .photo, content: imageUrl, position: CGPoint(x: 200, y: 200), width: 400, rotation: 0)
        //Must be changed to respnsive
        if let index = album.pages.firstIndex(where: {$0.id == selectedPage}) {
            album.pages[index].elements.append(newElement)
        } else {
           // item could not be found
        }
    }



    func saveJpg(image: UIImage, imageUrl: String) {
        //Should be done on backround thread
        let jpgData = image.jpegData(compressionQuality: 1)
        let path = AlbumManager().documentDirectoryPath().appendingPathComponent(imageUrl)
        try? jpgData?.write(to: path)
    }

    @State private var isShowingPhotoPicker = false
    @State private var isShowingAddElementView = false

    @State private var moreElementView: Bool = false


    @State var editable: Bool = false
    @State var selectedElement: String? = nil
    var albumManager = AlbumManager()


    func addPage(){
        let pageUUID = UUID()
        let newPage = Page(id: pageUUID, elements: [])
        album.pages.append(newPage)
    }

    func addImage(){
        showingImagePicker = true
    }

    // onAppear gets called only once when swiping between pages, still getImage gets called multiple times

   



    
    func renderPages() -> some View{
        return
            TabView(selection: $selectedPage) {
                ForEach($album.pages, id: \.id){ $page in
                    PageView(page: $page, editMode: $editMode )


                       



                }
            }.tabViewStyle(.page)
             .indexViewStyle(.page(backgroundDisplayMode: .always))



        }



    var body: some View{
        let pressGesture = LongPressGesture()
                   .onEnded { value in
                       withAnimation {
                           editMode = true
                       }
                   }

        VStack{

           //renderPages()
            

        }.border(editMode ? .gray : .clear, width: 2)
        .navigationTitle(album.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
                   
                    ToolbarItem(placement: .confirmationAction){

                        Button(action: {editMode.toggle()}) {
                            editMode ? Text("Done"): Text("Edit")

                            //Image(systemName: editable ? "pencil.circle.fill" : "pencil.circle")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){

                        Button(action: {addPage()}) {
                            Image(systemName: "plus")

                            //Image(systemName: editable ? "pencil.circle.fill" : "pencil.circle")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){

                        Button(action: {addImage()}) {
                            Image(systemName: "photo")

                            //Image(systemName: editable ? "pencil.circle.fill" : "pencil.circle")
                        }
                    }
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                .onAppear(perform:{
                })
                .onChange(of: inputImage) { _ in loadImage() }


    }

}
/*.sheet(isPresented: $isShowingPhotoPicker, content: {
    PhotoPicker(uploadedImage: $uploadedImage)
})
   .sheet(isPresented: $isShowingAddElementView, content: { AddElementView(didAddPage: {
            addPage()
    }, didAddImage: {
        addImage()
    })


    }).navigationBarHidden(true)


 */


/*
            GeometryReader{ geo in
               EditRectangleView().opacity(editable ? 1 : 0)

                Button(action:{showingImagePicker = true}){

                if let image = image {

                 image
                        .resizable()
                        .scaledToFill()
                        .frame(width:geo.frame(in: .local).width, height:geo.frame(in: .local).height)
                        .clipped()

                }else{


                            Image("blank_album_cover_image")
                            .resizable()
                            .scaledToFill()
                            .frame(width:geo.frame(in: .local).width, height:geo.frame(in: .local).height)






            }

            }
            .disabled(!editable)


            }.aspectRatio(3/4, contentMode: .fit)
                .padding(24)
*/


/* func imageChanged(){
     let elementUUID = UUID().uuidString
     guard let newImage = uploadedImage else{
return

     }
     saveJpg(image: newImage, imageUrl: elementUUID + ".jpg")
     let newElement = Element(id: elementUUID, type: ElementType(type: "image", url: elementUUID + ".jpg"), position: Position(x:500, y: 500), width: 500, rotation: 0)
  }

*/
  /*
  func albumIndex() -> Int {
      return ads.albumsData.firstIndex(where: {$0.id == albumId})!
  }

  func album() -> Album {
      return ads.albumsData.first(where: {$0.id == albumId})!
  }



  func renderHeaderView() -> some View {
      var editableHeaderView: some View{
          HStack{

              Button(action:  {
                  editable.toggle()
                  selectedElement = nil
              }){
                  Image("more_icon")
                      .padding(.leading, 12)
              }
              Spacer()
              Button(action:  {
                 isShowingAddElementView = true
              }){
                  Image("add_icon")
                      .padding(.trailing, 8)
              }
              Button(action:  {
                  editable.toggle()
                  selectedElement = nil
              }){
                  Image("done_icon")
                      .padding(.trailing, 18)
              }



          }
      }

      var headerView: some View{
          HStack{
              Image("back_icon").onTapGesture {
                  presentation.wrappedValue.dismiss()
              }
              .padding(.leading, 18)
              Spacer()
              Text(album().name)
                  .font(.custom("Merriweather-Bold", size: 18))
              Spacer()
              Button(action:  {
                  editable.toggle()
                  selectedElement = nil
              }){

                  Image("edit_icon")
                      .padding(.trailing, 18)


              }



          }
      }


      if(editable){
          return AnyView(editableHeaderView)
      }else {
          return AnyView(headerView)
      }
  }*/


extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}*/
