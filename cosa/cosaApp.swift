import SwiftUI

///Kertoo sovellukselle tämän olevan sovelluksen lähtöpiste
@main
///Entry point for the app
///Requires implementation of body-instance property
///Structs:
///have propetries like var length: Integer
///Define methods
///Define Subscripts, eg. array[2]
///Conform to protocols cosaApp: App
///Can be extended to provide new functionality: extension cosaApp
///Classes have a couple extra features like inheritance
///and should only be used when there's need for that.


///App protocol has a required instance property body
struct cosaApp: App {
    ///Single source of truth for the data inside the app. StateObject vs ObservedObject makes sure that the state of the app is preserved when updates happen.
    ///
    ///DataController loads the Album-datamodel from memory and shares it to the app here.
    @StateObject private var dataController = DataController()

    var body: some Scene {
        ///Scene consists of views. Scenes have their lifecycle managed by the system. WindowGroup implements
        ///Scene-protocol. On MacOS and iPadOS this allows for opening multiple windows of the same app. on iOS
        ///multitasking is not supported. Other possible type is DocumentGroup.
        ///
        ///WindowGroup initializer has a content closure. This closure is represented with the WindowGroup{} –syntax.
        ///
        WindowGroup {
            ///NavigationView is being replaced by NavigationStack from iOS 16.
            ///NavigationView conforms to View protocol, and creates the navigation logic for the app. It handles the
            ///navigation bar, it's title and back-button.  with toolbar –instance method you are able to add icons to the view
            ///inside NavigationView.

                ///Our main screen that gets opened when the app launches.
            HomeScreen()

                    ///We're passing the dataController through this modifier
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }

    }
}

