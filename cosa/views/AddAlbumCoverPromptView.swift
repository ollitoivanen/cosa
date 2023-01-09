
import Foundation
import SwiftUI

///View prompting the user to add an album cover image.
struct AddAlbumCoverPromptView: View {

    ///Used to change the border color of the add album cover –rectangle
    ///according to device's dark/light theme.
    @Environment(\.colorScheme) var colorScheme

    ///Size of the parent frame this view needs to fill.
    var frame: CGRect

    var body: some View{
        VStack{
            Text("+")
                .font(.system(.title))

            Text("Add album cover")
                .font(.system(.body))
        }
        .frame(width: frame.width,
               height: frame.height)
        .border(colorScheme == .light ? .black : .white, width: 2)
    }
}
