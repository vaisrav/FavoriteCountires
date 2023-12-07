//import SwiftUI
//struct ContentView: View {
//    
////    @State var countryList:[Country] = [
////        Country(name: Name(common: "India"),
////                capital: ["New Delhi"],
////                population: 213123221,
////                area: 22332.0,
////                flags: Flag(png: "https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1350px-Flag_of_India.svg.png"),
////                capitalInfo: CapitalInfo(latlng: [20.59, 78.96])
////               )
////    ]
////    
////    var body: some View {
////        VStack {
////            // make a button
////            // when person presssed the button
////            // connect to api and display the data
////            // in the console
////            Text("API Demo")
//////            Button {
//////                // code to connect to api
//////                loadDataFromAPI()
//////            } label: {
//////                Text("Get Data!")
//////            }
//////
////            // list to display data
////            List {
////                // loop through each item in your datasource
////                // .id = the id property in the User struct
////                // this is the property that uniquey identifies each object
////                ForEach(countryList, id:\.name.common) {
////                    currCountry in
////                    // UI for each row
////                    HStack {
////                        AsyncImage(url:URL(string:currCountry.flags.png))
////                            .scaledToFit()
////                            .frame(width: 50, height: 50)
////                        Spacer()
////                        VStack(alignment: .trailing){
////                            Text(currCountry.name.common)
////                            Spacer()
////                            Text(currCountry.capital[0])
//////                            Spacer()
//////                            Text("\(currCountry.population)")
//////                            Spacer()
//////                            Text("\(currCountry.area)")
//////                            Spacer()
//////                            Text("\(currCountry.capitalInfo.latlng[0]), \(currCountry.capitalInfo.latlng[1])")
////                        }
////                    }
////                    Spacer()
//////                    Text(currCountry.strInstructions)
//////                    AsyncImage(url:URL(string:currRecipe.strMealThumb))
////                }
////                
////            }
////        }
////        .padding()
////        .onAppear {
////            // lifecycle funciton that executes
////            // when the screen loads
////            loadDataFromAPI()
////        }
////    }   // end body
////    
////    func loadDataFromAPI() {
////        print("Getting data from API")
////        
////        let websiteAddress:String
////            = "https://restcountries.com/v3.1/independent?status=true"
////        
////        guard let apiURL = URL(string: websiteAddress) else {
////            print("ERROR: Cannot convert api address to an URL object")
////            return
////        }
////        
////        let request = URLRequest(url:apiURL)
////        
////        let task = URLSession.shared.dataTask(with: request) {
////            (data:Data?, response, error:Error?) in
////   
////            if let error = error {
////                print("ERROR: Network error: \(error)")
////                return
////            }
////            
////            if let jsonData = data {
////                print("data retreived")
////                if let decodedResponse
////                    = try? JSONDecoder().decode([Country].self, from:jsonData) {
////                    // if conversion successful, then output it to the console
////                    DispatchQueue.main.async {
////                        print(decodedResponse)
////                        
//////                        var recipes = decodedResponse.meals
//////                        self.recipesList = recipes
////                        self.countryList = decodedResponse
////                    }
////                }
////                else {
////                    print("ERROR: Error converting data to JSON")
////                }
////            }
////            else {
////                print("ERROR: Did not receive data from the API")
////            }
////        }
////        task.resume()
////        
////    }
//} // end ContentView struct
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
