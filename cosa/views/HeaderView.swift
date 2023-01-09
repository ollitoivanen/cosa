import SwiftUI

struct HeaderView: View{
   
    @Environment(\.presentationMode) var presentation
    
    var headerTitle: String
    var LeftHeaderItem = Image("blank_icon")
    var RightHeaderItem = Image("blank_icon")
    var LeftHeaderItemDestination: AnyView?
    var RightHeaderItemDestination: AnyView?
    
    func buildLeftHeaderItem()-> some View{
        if LeftHeaderItemDestination == nil {
            if(LeftHeaderItem == Image("back_icon")){
                return AnyView(Button(action:{}){
                    LeftHeaderItem.onTapGesture {
                        presentation.wrappedValue.dismiss()

                    }
                                .padding(.leading, 18)
                })

                
            }else{
                return AnyView(LeftHeaderItem
                                .padding(.leading, 18))
            }
          
        }else{
            return AnyView(NavigationLink(destination: LeftHeaderItemDestination){
                LeftHeaderItem.padding(.leading, 18)

            })
        }
    }
    
    func buildRightHeaderItem()-> some View{
        if RightHeaderItemDestination == nil {
            return AnyView(RightHeaderItem
                            .padding(.trailing, 18))
        }else{
            return AnyView(NavigationLink(destination: RightHeaderItemDestination){
                RightHeaderItem.padding(.trailing, 18)

            })
        }
    }
    
    var body: some View{
        HStack{
            
           buildLeftHeaderItem()
            Spacer()
            Text(headerTitle)
                .font(.custom("Merriweather-Bold", size: 18))
            Spacer()
           buildRightHeaderItem()
            


        }.padding(.top, 0)
    }
}

struct HeaderView_Previews: PreviewProvider{
    static var previews: some View {
        HeaderView(headerTitle: "Photo albums", LeftHeaderItem: Image("add_icon"), RightHeaderItem: Image("add_icon"))
    }
}
