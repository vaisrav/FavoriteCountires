//
//  CountriesListView.swift
//  vaisrav-final
//
//  Created by Graphic on 2023-07-11.
//

import SwiftUI

struct CountriesListView: View {
    @State var countryList:[Country] = [
        Country(name: Name(common: "India"),
                capital: ["New Delhi"],
                population: 213123221,
                area: 22332.0,
                flags: Flag(png: "https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1350px-Flag_of_India.svg.png"),
                capitalInfo: CapitalInfo(latlng: [20.59, 78.96])
               )
    ]
    
    var body: some View {
        VStack {
            
            Text("Countries List")
            NavigationView {
                List {
                    ForEach(countryList, id:\.name.common) {
                        currCountry in
                        NavigationLink{
                            CountryDetailsView(selectedCountry : currCountry)
                        }label: {
                            HStack {
                                AsyncImage(
                                    url: URL(string:currCountry.flags.png),
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
                                    Text(currCountry.name.common)
                                    Text(currCountry.capital[0])
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            // lifecycle funciton that executes
            // when the screen loads
            loadDataFromAPI()
        }
    }   // end body
    
    func loadDataFromAPI() {
        print("Getting data from API")
        
        let websiteAddress:String
            = "https://restcountries.com/v3.1/independent?status=true"
        
        guard let apiURL = URL(string: websiteAddress) else {
            print("ERROR: Cannot convert api address to an URL object")
            return
        }
        
        let request = URLRequest(url:apiURL)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data:Data?, response, error:Error?) in
   
            if let error = error {
                print("ERROR: Network error: \(error)")
                return
            }
            
            if let jsonData = data {
                print("data retreived")
                if let decodedResponse
                    = try? JSONDecoder().decode([Country].self, from:jsonData) {
                    // if conversion successful, then output it to the console
                    DispatchQueue.main.async {
//                        print(decodedResponse)
                        
                        self.countryList = decodedResponse
                    }
                }
                else {
                    print("ERROR: Error converting data to JSON")
                }
            }
            else {
                print("ERROR: Did not receive data from the API")
            }
        }
        task.resume()
        
    }
}

struct CountriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesListView()
    }
}
