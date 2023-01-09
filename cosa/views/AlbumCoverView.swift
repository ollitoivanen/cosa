import SwiftUI
///This struct is static meaning taht it doesn't need to do any modifications to the data it has, as all the
///updates will be received from the parent causing re-renders in this View too.
struct AlbumCoverView: View, Equatable {
    let album: Album


    func loadCoverImage () -> Image{
        guard let data = album.coverImage, let loaded = UIImage(data: data) else{
            return Image("blank_album_cover_image")
        }
        return Image(uiImage: loaded)
    }

    ///Using example data
    var AlbumCoverImage: Image {
        loadCoverImage()
    }

    var body: some View{
        ///TODO Weakness but will do for MVP.
                AlbumCoverImage
                ///Able to resize image
                    .resizable()
                ///Fills the whole of parent, even if it causes overflow.
                    .scaledToFill()
            ///Sets one cover images width
                    .frame(width: (UIScreen.main.bounds.size.width-32)/2)
                ///Clips the overflow caused by .scaledToFill()
                    .clipped()
                    .cornerRadius(8)
                    ///Ends expansion on the first constraining wall it hits.
                    .aspectRatio(3/4, contentMode: .fit)
                ///Overlays the album name over the Image
                    .overlay(
                        Text(album.name!)
                            .font(.system(.title3, design: .serif))
                            .foregroundColor(.white)
                            .bold()
                            .padding(EdgeInsets(top: 0,leading: 8, bottom: 8, trailing: 16)),alignment: .bottomLeading)




        
        
        
    }


    
}
