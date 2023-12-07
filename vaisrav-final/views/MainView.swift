//
//  MainView.swift
//  vaisrav-final
//
//  Created by Graphic on 2023-07-11.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            TabView {
                CountriesListView()
                    .tabItem{
                        Label("Countries List", systemImage: "globe.desk")
                    }
                FavoritesListView()
                    .tabItem{
                        Label("Favorites List", systemImage: "text.badge.star")
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
