//
//  CountryDetailsView.swift
//  vaisrav-final
//
//  Created by Graphic on 2023-07-11.
//

import SwiftUI
import MapKit
import CoreData

struct CountryDetailsView: View {
    
    var selectedCountry : Country
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var favorites: FetchedResults<FavCountry>
        
        
    
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string:selectedCountry.flags.png),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200)
                },
                placeholder: {
                    ProgressView().padding(10)
                }
            )
            Text("Name: \(selectedCountry.name.common)")
            Text("Capital: \(selectedCountry.capital[0])")
            Text("Total Population: \(selectedCountry.population)")
            Text("Total Area: \(selectedCountry.area)")
            MyMap(lat: selectedCountry.capitalInfo.latlng[0], lng: selectedCountry.capitalInfo.latlng[1])
                .padding(12)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if isCountryInFavorites() {
                        alertMessage = "The country is already in your favorites list."
                    } else {
                        addCountryToFavorites()
                        alertMessage = "The country has been added to your favorites list."
                    }
                    showAlert = true
                }) {
                    Text("Mark as Fav")
                        .foregroundColor(.blue)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alert"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func isCountryInFavorites() -> Bool {
        let countryName = selectedCountry.name.common.lowercased()
        print("isCountryInFavorites is working")
        let result = favorites.contains { $0.name.lowercased() == countryName }
        return result
    }
    private func addCountryToFavorites() {
        let countryName = selectedCountry.name.common
        let isCountryAlreadyFavorite = favorites.contains { $0.name == countryName }
        
        guard !isCountryAlreadyFavorite else {
            showAlert = true
            return
        }
        
        let favoriteCountry = FavCountry(context: viewContext)
        favoriteCountry.id = UUID()
        favoriteCountry.name = selectedCountry.name.common
        favoriteCountry.capital = selectedCountry.capital[0]
        favoriteCountry.population = Int64(selectedCountry.population)
        favoriteCountry.flag = selectedCountry.flags.png
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error! \(nsError.userInfo)")
        }
    }
}



struct MyMap : UIViewRepresentable{
    
    typealias UIViewType = MKMapView
    
    //private var location : CLLocation
    private var lat : Double
    private var  lng : Double
    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let sourceCoordinates: CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        sourceCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        let map = MKMapView(frame: .infinite)
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isUserInteractionEnabled = true
        map.showsUserLocation = true
        map.setRegion(region, animated: true)
        
        return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //code
        
        let sourceCoordinates: CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        sourceCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = sourceCoordinates
        mapAnnotation.title = "Country's Capital"
        
        uiView.setRegion(region, animated: true)
        uiView.addAnnotation(mapAnnotation)
    }
}


//struct CountryDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryDetailsView()
//    }
//}
