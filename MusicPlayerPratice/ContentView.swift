//
//  ContentView.swift
//  MusicPlayerPratice
//
//  Created by (^ㅗ^)7 iMac on 2022/11/19.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            PlayerView()
                .tag(0)
                .tabItem {
                    VStack {
                        Image(systemName: "music.note")
                        Text("Player")
                    }
                }
            SearchView()
                .tag(1)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
            }
        .accentColor(.pink)
        .onAppear() {
            SKCloudServiceController.requestAuthorization { (status) in
                if status == .authorized {
                    print(AppleMusicAPI().fetchStorefrontID())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .colorScheme(.dark)
            .previewDevice(.init(rawValue: "iPhone 14 pro"))
    }
}

