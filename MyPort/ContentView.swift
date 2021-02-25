//
//  ContentView.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
        }
            
    }
}
