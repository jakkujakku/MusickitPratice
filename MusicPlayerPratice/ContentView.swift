//
//  ContentView.swift
//  MusicPlayerPratice
//
//  Created by (^ㅗ^)7 iMac on 2022/11/19.
//

import SwiftUI
import StoreKit
import MediaPlayer

struct ContentView: View {
    @State private var currentSong = Song(id: "", name: "", artistName: "", artworkURL: "")
    @State private var selection = 0
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    var body: some View {
        TabView(selection: $selection) {
            PlayerView(musicPlayer: self.$musicPlayer, currentSong: self.$currentSong)
                .tag(0)
                .tabItem {
                    VStack {
                        Image(systemName: "music.note")
                        Text("Player")
                    }
                }
            SearchView(musicPlayer: self.$musicPlayer, currentSong: self.$currentSong)
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
                    print(AppleMusicAPI().searchAppleMusic("IU"))
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

