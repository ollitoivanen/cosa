import SwiftUI

struct NewAlbumView: View{

    ///Variable for dismissing the new album modal.
    @Environment(\.dismiss) var dismiss
    ///Variable keeping the app data up to date.
    @Environment(\.managedObjectContext) var moc

    @FocusState private var focusingTextField: Bool

    @State private var canCreate: Bool = false
    @State private var name: String = ""

    ///Dictates whether or not the image picker –sheet is shown.
    @State private var showingImagePicker = false

    @State private var inputImage: UIImage? = nil
    @State private var image: Image?

    func loadImage() {
        guard var selectedImage = inputImage else { return }
        ///Resizes the cover image to half the size of the original. selectedImage is the one being displayed,
        ///inputImage is a state so updating it here to lwer quality would create an infinite loop.
        ///TODO disabled for MVP
        image = Image(uiImage: selectedImage)
    }

    ///Prevents from creating albums without name
    func checkLength(){
        if(name.count > 0){
            canCreate = true
        }else{
            canCreate = false
        }
    }

    var body: some View{
        NavigationView{
            ///Aligns album cover and  text input vertically
            VStack{
                ///Registers the click to open image picker
                Button(action:{ showingImagePicker = true }){
                    ///Calculates the space which Button occupies
                    GeometryReader{ geo in
                        ///True if image has been selected from the image picker.
                        if let image = image {
                            ///Place image inside the Button.
                            image
                                .resizable()

                                .scaledToFill()
                                .frame(minWidth:geo.frame(in: .local).width, minHeight:geo.frame(in: .local).height)
                                .clipped()
                                .cornerRadius(8)

                        ///Else show prompt to select image.
                        }else{
                            AddAlbumCoverPromptView(frame: geo.frame(in: .local))
                        }
                    }
                }

                ///Sets the size of the Button to which the children conform through frame.
                .aspectRatio(3/4, contentMode: .fit)
                .padding(EdgeInsets(top: 25, leading: 50, bottom: 0, trailing: 50))

                ///Shows the image picker 
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                ///Fills the image-variable with the selected image
                .onChange(of: inputImage) { _ in loadImage() }

                TextField(
                    "Album name",
                    text: $name
                )
                .focused($focusingTextField)
                .multilineTextAlignment(.center)
                .padding(8)
                .font(.system(.title))
                .onAppear {
                    focusingTextField = true
                }

                Spacer()
            }
            .onChange(of: name){_ in checkLength()}
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let album = Album(context: moc)
                        album.id = UUID()
                        album.dateCreated = Date()
                        album.name = name
                        album.coverImage = inputImage?
                        ///TODO disabled for MVP causes landscape images to be compressed more
                            //.aspectFittedToWidth(1008)
                            .jpegData(compressionQuality: 1)

                        let initialPage = Page(context: moc)
                        initialPage.id = UUID()
                        album.addToPages(initialPage)
                        try? moc.save()
                        dismiss()
                    }.disabled(!canCreate)
                }
            }
        }
    }
}
