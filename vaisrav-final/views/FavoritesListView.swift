import SwiftUI
import CoreData

struct FavoritesListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: FavCountry.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FavCountry.name, ascending: true)
        ]
    )
    private var favorites: FetchedResults<FavCountry>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favorites, id:\.id) { favorite in
                    VStack(alignment: .leading) {
                        HStack{
                            AsyncImage(
                                url: URL(string:favorite.flag),
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 100)
                                },
                                placeholder: {
                                    ProgressView().padding(10)
                                }
                            )
                            Spacer()
                            VStack(alignment: .trailing){
                                Text(favorite.name )
                                    .font(.headline)
                                Text("Capital: \(favorite.capital )")
                                    .font(.subheadline)
                                Text("Population: \(favorite.population)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteFavorites)
            }
            .navigationTitle("Favorites")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private func deleteFavorites(at offsets: IndexSet) {
       offsets.forEach { index in
            let favorite = favorites[index]
            viewContext.delete(favorite)
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error! \(nsError.userInfo)")
        }
    }
}
