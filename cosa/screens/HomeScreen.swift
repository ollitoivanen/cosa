import SwiftUI

struct HomeScreen: View {
    ///Supplied by the StateObject
    @Environment(\.managedObjectContext) var moc

    ///Fetches albums from the persistent store and saves them to the variable
    ///Doesn't fetch pages or elements. Those are only related and need to be fetched
    ///seperately.
    @FetchRequest(sortDescriptors: []) var albums: FetchedResults<Album>

    ///The AlbumEditView has one modal delegated to it, and this state gets populated with the data
    ///of the long-pressed album.
    @State var longPressedAlbum: Album? = nil
    @State var openedAlbum: Album? = nil
    @State var albumOpen = false


    ///State which controls wheter or not the NewAlbumView-sheet is presented.
    @State var newAlbumModalOpen: Bool = false

    func fetchPages(album: Album) -> [Page]{
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

    ///Defines the grid layout of the list. Spacing defines the horizontal padding between columns.
    let gridItemLayout: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        NavigationView{

            ScrollView{
                ///NavigationLink taking you to the AlbumScreen. selectedPage
                ///is required to be passed through for TabView to register it.
                if(openedAlbum != nil){
                    NavigationLink(destination: AlbumScreen(album: openedAlbum!, selectedPage: fetchPages(album: openedAlbum!)[0]),isActive: $albumOpen){
                        EmptyView()
                    }
                }

                ///Spacing defines the vertical padding between rows
                LazyVGrid(columns: gridItemLayout, spacing: 16){
                    ///As albumStore updates with the data, this gets re-rendered.
                    ForEach(albums){ album in

                        AlbumCoverView(album: album)
                            .onTapGesture {
                                openedAlbum = album
                                albumOpen = true
                            }
                            .onLongPressGesture {
                            ///Vibrates the device when long pressed.
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()

                            ///Opens a modal with the data of the long-pressed album.
                            longPressedAlbum = album
                        }
                }
                ///Padding outside the Grid List
                .padding(0)
                ///Presents the AlbumEditView-sheet when an album has been long-pressed
                ///causing the state to be non-nil
                .sheet(item: $longPressedAlbum){ album in
                    AlbumEditView(album: album)
                }

            }

        }
        ///Sheet for presenting the View for creating a new album.
        .sheet(isPresented: $newAlbumModalOpen){
            NewAlbumView()
                .interactiveDismissDisabled(true)
        }
        .navigationTitle("Albums")
            .toolbar {
                Button(action: {newAlbumModalOpen.toggle()}) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Album")
            }
        }

    }
/* ///Replaced by environmentObject
 ///@Binding var albums: [Album]
 @State private var newAlbumData = Album.Data()

 @Environment(\.scenePhase) private var scenePhase
 let saveAction: ()-> Void

 @State var isShowingNewAlbumScreen: Bool = false
 @State var selectedAlbum: String? = nil
 @State var selectedAlbumDetail: Album? = nil

 let albumManager = AlbumManager()

 func getAlbumName(albumName: String?)-> String {
 guard let albumName = albumName else {
 return ""
 }
 return albumName

 }

 let gridItemLayout: [GridItem] = Array(repeating: GridItem(.flexible(),spacing: 16), count: 2)

 var body: some View{
 VStack{
 // HeaderView

 ScrollView{
 LazyVGrid(columns: gridItemLayout, spacing: 16){
 ForEach($albums){ $album in
 NavigationLink(destination: AlbumScreen(album: $album, selectedPage: album.pages[0].id)){
 AlbumCoverView(album: album)
 }


 }

 }.padding(16)

 }.navigationTitle("Albums")
 .toolbar {
 Button(action: {isShowingNewAlbumScreen = true}) {
 Image(systemName: "plus")
 }
 .accessibilityLabel("New Album")
 }


 }
 .sheet(isPresented: $isShowingNewAlbumScreen) {
 NavigationView {
 NewAlbumScreen(data: $newAlbumData)
 .toolbar {
 ToolbarItem(placement: .cancellationAction) {
 Button("Dismiss") {
 isShowingNewAlbumScreen = false
 newAlbumData = Album.Data()
 }
 }
 ToolbarItem(placement: .confirmationAction) {
 Button("Add") {

 let newAlbum = Album(data: newAlbumData)
 albums.append(newAlbum)
 isShowingNewAlbumScreen = false
 newAlbumData = Album.Data()
 }.disabled(newAlbumData.name.count < 1)
 }
 }
 }
 }
 .onChange(of: scenePhase) { phase in
 if phase == .inactive { saveAction() }
 }



 }





 */
    
}

