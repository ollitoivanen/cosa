import Foundation
import SwiftUI
struct AlbumManager{
    func documentDirectoryPath() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask)
        return path[0]
    }


    func getImageElement(imageUrl: String)->Image{
        let path = documentDirectoryPath().appendingPathComponent(imageUrl)
        guard let data = try? Data(contentsOf: path), let loaded = UIImage(data: data) else{
            return Image("blank_album_cover_image")
        }
        
        return Image(uiImage: loaded)
    }
    /*
     Album loading mechanism:
     1. AlbumsScreen calls to get data
     2. Check if file albums.json exists
        a) Exists, load data
        b) Doesn't, create file with an empty Array
     
     Album cover image loading mechanism:
     1. On creation, check if cover image has been added.
     3. 
     
     
     
     
     */
    
    

   /* let fileManager = FileManager.default
    


    func getAlbumsData() -> [Album] {
        
        let albumsJSONPath = documentDirectoryPath().appendingPathComponent("albums.json")

        if(fileExists(atURL: albumsJSONPath)) {
            do {
                let data = try Data(contentsOf: albumsJSONPath)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Albums.self, from: data)
                return jsonData.albums
                
                
            } catch {
                return []
            }
        }else{
            return []
        }
    }
    
    func fileExists(atURL: URL) -> Bool {
        fileManager.fileExists(atPath: atURL.path) ?  true :  false
    }

   
    /*func createAlbumsFile(){
        if(fileManager.createFile(atPath: self.albumsPath.absoluteString, contents: nil, attributes: nil)){
        }else{
        }

        
    }*/

    /*func getAlbumsPath() -> URL{
        print(pathExists())
        if(pathExists()){
          
                /*let items = try fileManager.contentsOfDirectory(atPath: albumsPath.absoluteString)
                for item in items {
                    print("Found \(item)")*/
                return albumsPath
            
        }else{
            createAlbumsFile()

            
        }
    }
    
    
    
    func getAlbumCoverImage(coverImageUrl:String?)->Image{
        guard let coverImageUrl = coverImageUrl else {
            return Image("blank_album_cover_image")
        }
        let path = documentDirectoryPath().appendingPathComponent(coverImageUrl)
        guard let data = try? Data(contentsOf: path), let loaded = UIImage(data: data) else{
            return Image("blank_album_cover_image")
        }
        return Image(uiImage: loaded)
    }
     */
    
    
    func findElement(elementData: Element)-> Element{
        if let albumIndex = ads.albumsData.firstIndex(where: { $0.id == ads.selectedAlbum?.id }){
            if let pageIndex = ads.albumsData[albumIndex].pages.firstIndex(where: { $0.id == ads.selectedPage?.id }){
                if let elementIndex = ads.albumsData[albumIndex].pages[pageIndex].elements.firstIndex(where: { $0.id == ads.selectedElement?.id }){
                    return ads.albumsData[albumIndex].pages[pageIndex].elements[elementIndex]

                }
            }

        }
    
        
        

    }*/


}
