import SwiftUI

///View responsible for displaying the view where user can change the cover image and name of the album
///as well as delete the album
struct AlbumEditView: View {

    ///Variable for dismissing the editing modal.
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc


    ///Environment object where we make the possible updates to data.
   // @EnvironmentObject var albumStore: AlbumStore
    @State var editedAlbumName = ""
    ///The album data we get from the HomeScreen
    var album: Album

    //var albumId: String
    //@State var albumName: String
    //@State var albumCoverImage: Image

    ///Function used to update the AlbumStore
   /* func updateAlbumStore(){
        ///Finding the index of our current album in the AlbumStore
        ///Error here shouldn't be possible
        if let albumIndex = albumStore.albums.firstIndex(where:{$0.id == album.id}){
            albumStore.albums[albumIndex] = album
        }
        ///Close the sheet
        dismiss()
    }
*/
    var body: some View{
        ///Allows toolbar to be shown
        NavigationView{
            ///Orders image and textfield
            VStack{
                ///Used to calculate the VStack's size to inside of which the Image fits.
                GeometryReader{ geo in
                    Image("blank_album_cover_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width:geo.frame(in: .local).width,
                               height:geo.frame(in: .local).height)
                        .clipped()

                }
                .aspectRatio(3/4, contentMode: .fit)

                ///TODO Needs to be updated to have a maximum length
                TextField("Album name", text: $editedAlbumName)
                    .multilineTextAlignment(.center)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            .padding(24)
            ///Used to display the toolbar with action items.
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        album.name = editedAlbumName
                        try? moc.save()
                        dismiss()
                    }
                }
            }
        }.onAppear{
            editedAlbumName = album.name!
        }
    }
}

