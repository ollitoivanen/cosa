/*
import Foundation
import SwiftUI


class AlbumStore: ObservableObject {
    ///The system only follows the changes of the published properties. It also creates overhead which should be avoided
    ///whenever possible, eg. identifiers that never change.
    ///
    ///Changes that happen to this property will cause updates in all parts of the app that depend on that property.
    ///
    ///Our data model consists of albums. Each album contains pages and each page elements. At the point of implementing
    ///the creation and editing the album, it's name and cover we want to be able to edit these properties and have them reflected immeadiately on the UI. To do this, we need to create a observable data model that consists of array of albums.
    ///
    ///Album needs to have an identifier, name, creation date and image as properties. This [Album] is then passed as an
    ///environment object to the AlbumsScreen. This screen contains a list of albums. We are able to edit a single instance of Album, and these changes need to be reflected to the store immediately. For this we need a Binding for two-way dependece; changes in store will be reflected to the UI but the user is also able to edit the store, leading to the former.
    ///
    ///Next we'll create dummy data to test wheter updating fields of and object inside published variable will cause a refresh.
    ///This data needs to be set to the store after launch in App, as property inizializer runs before the testAlbums is ready.

    ///When we 
   // @Published var albums: [Album] = []

























    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("albums.data")

    }

    static func loadAlbums(completion: @escaping (Result<[Album], Error>) -> Void){
        DispatchQueue.global(qos: .background).async {
            do {
                let fileUrl = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileUrl) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }

                return

                }

                let albums = try JSONDecoder().decode([Album].self, from: file.availableData)
                DispatchQueue.main.async {
                                    completion(.success(albums))
                }
            } catch {
                DispatchQueue.main.async {
                                   completion(.failure(error))
                }
            }
        }
    }

    static func saveAlbums(albums: [Album], completion: @escaping (Result<Int, Error>) -> Void) {
           DispatchQueue.global(qos: .background).async {
               do {

                   let data = try JSONEncoder().encode(albums)
                   let outfile = try fileURL()
                   try data.write(to: outfile)
                   DispatchQueue.main.async {
                       completion(.success(albums.count))
                   }
               } catch {
                   DispatchQueue.main.async {
                       completion(.failure(error))
                   }
               }
           }
       }


 
   /* static func loadImage(imageUrl: String, completion: @escaping (Result<Image, Error>) -> Void) {
        let path = AlbumManager().documentDirectoryPath().appendingPathComponent(imageUrl)
        DispatchQueue.global()
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: path)
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async{
                    completion(.success(Image(uiImage: uiImage!)))
                }
                return
            }catch{
                completion(.failure(error))
            }
        }

    }

    static func loadImages(elements: [Element], completion: @escaping (Result<[Image], Error>) -> Void) {
        var loadedImages: [Image] = []

        let path = AlbumManager().documentDirectoryPath()
        DispatchQueue.global(qos: .background).async {
            do {
                 for element in elements {
                    let data = try Data(contentsOf: path.appendingPathComponent(element.content))
                    let uiImage = UIImage(data: data)
                     element Image(uiImage: uiImage!)

                }

                DispatchQueue.main.async{
                    completion(.success(loadedImages))
                }
                return
            }catch{
                completion(.failure(error))
            }
        }

    }*/
}
*/
