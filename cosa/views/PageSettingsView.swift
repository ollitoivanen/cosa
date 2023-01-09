import SwiftUI

struct PageSettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    var didAddPage: () -> ()
    var body: some View {
        VStack{
            List{
                Button(action:{ presentationMode.wrappedValue.dismiss()
                    self.didAddPage()

                }){
                    Text("Page").font(.custom("Merriweather-Bold", size: 24)).padding()
                }

                Text("Image").font(.custom("Merriweather-Bold", size: 24)).padding()
            }

        }
    }
}
