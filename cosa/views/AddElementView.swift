import SwiftUI

struct AddElementView: View {
    @Environment(\.presentationMode) var presentationMode

    var didAddPage: () -> ()
    var didAddImage: () -> ()
    var body: some View {
        VStack{
            List{
                Button(action:{ presentationMode.wrappedValue.dismiss()
                    self.didAddPage()

                }){
                    Text("Page").font(.custom("Merriweather-Bold", size: 24)).padding()
                }
                Button(action:{ presentationMode.wrappedValue.dismiss()
                    self.didAddImage()

                }){
                Text("Image").font(.custom("Merriweather-Bold", size: 24)).padding()
            }
            }

        }
    }
}
