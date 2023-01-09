import SwiftUI
import Foundation

struct PhotoElementView: View {
   /* let albumManager = AlbumManager()
    @Binding var element: Element
    @State var frame: CGSize
    @Binding var editMode: Bool*/

    //var image: Image
    @State var element: Element
    @Environment(\.managedObjectContext) var moc

    @State var longPressComplete: Bool = false
    @State var offset: CGSize = .zero
    @GestureState var scale = 1.0

    @GestureState var isDetectingLongPress = false


    /*Jokaisella kuvaelementillä on aluksi vakioarvo, placeholder. Kun elementti saapuu näytölle onAppear-metodia kutsuttaessa, aloitetaan kuvan lataaminen tiedostoista. Kuvan lataaminen on async-funktio. Sen ollessa valmis, kuvan vakioarvon state päivitetään vastaamaan tätä.

     Ongelma 1: onappear ei salli async-funktioita. task() modifier sallii async-koodin suorittamisen heti elementin tullessa ruudulle. se myös automaattisesti keskyttää koodin suorituksen, jos elementti tuhotaan. Kokeillaan. Suoritus onnistuu. Kutkutusta. Rumpujen pärinää. TATTADADAAA kuvat latautuu. Hitto sää oot olli hyvä!

     nyt kun kuvien lataus onnistuu aina uuden sivun latauduttua ja vielä asynkronoidusti, on seuraavaksi vuorossa rasitustestaus. lisätään jokeiselle sivulle monia kuvia (n. 10 kpl), ja katsotaan pysyykö suorituskyky hyvänä.

     no eipäs pysynyt. kun yhdelle sivulle oli ladattu kymmenen kuvaa, oli sille siirtyminen erittäin hidasta. muille sivuille siirtyminen oli edelleen nopeaa. latausnopeuksia katsoessa ensimmäiset kolme kuvaa latautuivat nopeasti alle 10ms, mutta loput kuvat latautuivat tasaisesti 80ms. Kun albumi avataan ensimmäistä kertaa, voidan placeholder-kuva nähdä hetken aikaa, jonka jälkeen kuvat ilmestyvät. Tällä kertaa latausajat ovat kuitenkin paremmat: 5,7,9,10,13,13,14,17,17,17. Nämäkin kuitenkin näyttävät vaihtelevan valtavasti latauskerotjen välillä.

     Ratkaisuvaihteoehto 1. korvataan  Image-tyyppinen placeholder kustannusystävällisellä Viewillä.

     Ratkaisuvaihtoehto 2. Koska sivu on yksi kokonaisuus, voidan ajatella, että kuvien yhtäaiakinen latautuminen on prioriteetti. tällöin logiikka tulisi siirtää PageViewiin, jossa latausindikaattori näytettäisiin niin kauan, kunnes se on onnistunut latamaan kaikki kuvaelementit. (toisaalta jatkossa haluamme myös bufferoida sivuja, jolloin latausindikaattoria ei tulisi näkyä käyttäjälle lainkaan).

     (Myös bufferoinnin kannalta pageview on oikea abstraktiotaso.)

     Let's kokeillaan. Tehtävävaiheet:
     1. Päivitä pageview käyttökuntoon aka siirrä logiikka albumscreenin page-tasolta pageviewiin.

     2. Kirjoita latausindikaattori, joka näkyy staten ollessa [].

     3. Kirjoita funktio, joka lataa sivun kaikki elementit asynkronoidusti. tämän tulleessa valmiiksi päivitä state latausindikaattorille [Elements].

     Tämä keskitetty lataus takaa myös sen, ettei synnytetä monta threadia jokaisen yksittäisen PhotoElementViewin async-kutsun toimesta, vaan yksi async-kutsu hoitaa kaikkien kuvien lataamisen. Tämä minun teoriassa vähentäisi lagia sivulle siirtyessä.


     */

    //@State var displayedImage: Image = Image("placeholder")

    

    func dragEnded(){
        print("old\(element.positionX)")
        element.positionX += (Float(offset.width*1080)/Float(UIScreen.main.bounds.size.width))
        element.positionY += (Float(offset.width*1920)/Float(UIScreen.main.bounds.size.height))
        try? moc.save()
        print("new\(element.positionX)")


    }
    var dragAndScaleGesture: some Gesture{
        DragGesture()
            .onChanged{ value in
                offset = value.translation
            }
            .onEnded{ _ in
                dragEnded()
                print("drag ended")
            }.simultaneously(with:
                MagnificationGesture()
                .updating($scale) { currentState, gestureState, transaction in
                    gestureState = currentState
                }.onEnded{_ in
                    print("scale ended")
                }
            )
    }
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 1, maximumDistance: 0)
            .onChanged{ ll in
                print("changed: \(ll)")
            }
                .updating($isDetectingLongPress) { currentState, gestureState,
                        transaction in



                    gestureState = currentState
                    print("current: \(currentState)")
                    print("gesture: \(gestureState)")
                    print("trans: \(transaction)")
                }
        ///OnEnded = have been pressing for minimumDuration.
                .onEnded { finished in
                     longPressComplete = true
                }
        }

    func dataToImage() -> Image {
        guard let data = element.image, let loaded = UIImage(data: data) else{
            return Image("blank_album_cover_image")
        }
        return Image(uiImage: loaded)    }

    var body: some View {

        let scaleGesture = MagnificationGesture()
             .updating($scale) { currentState, gestureState, transaction in
                 gestureState = currentState
             }

        let dragGesture = DragGesture()
                   .onChanged { value in
                       offset = value.translation
                   }
                   .onEnded {_ in
                       //dragEnded()
                   }

        dataToImage()
            .resizable()
            .scaledToFit()
        ///Elementin koko on annettu välillä 0-1080. Tässä laskemme suhdeluvun, jolla voimme pirtää laitteen ruudun leveyteen
        ///suhteutettuna kuvan oikean kokoisena.
            .frame(width: CGFloat(element.width)/1080 * UIScreen.main.bounds.size.width*scale)
            .position(x: CGFloat(element.positionX)/1080*UIScreen.main.bounds.size.width,
                      y: CGFloat(element.positionY)/1920*UIScreen.main.bounds.size.height)
            //.scaleEffect(scale)
            //.gesture(longPressGesture)
            .opacity(longPressComplete ? 0.75 : 1)
            .offset(offset)
            .gesture(dragAndScaleGesture)

       /*

        let scaleGesture = MagnificationGesture()
             .updating($scale) { currentState, gestureState, transaction in
                 gestureState = currentState
             }

        let dragGesture = DragGesture()
                   .onChanged { value in
                       offset = value.translation
                   }
                   .onEnded {_ in
                       dragEnded()
                   }

               // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture(minimumDuration: 0.1)
                   .onEnded { value in
                       withAnimation {
                           editMode = true
                       }
                   }

               // a combined gesture that forces the user to long press then drag

        let combined = pressGesture.simultaneously(with: dragGesture)*/
        //let img = albumManager.getImageElement(imageUrl: element.content)


          .onChange(of: element.positionX) { value in
                //Makes sure that the offset is reset only after elemnt state is updated
                //Gets rid of jumping around when offset is reset before state change
                offset = .zero
           }

    }
}

