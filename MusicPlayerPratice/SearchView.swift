//
//  SearchView.swift
//  MusicPlayerPratice
//
//  Created by (^ㅗ^)7 iMac on 2022/11/19.
//

import SwiftUI
import StoreKit

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults = [Song]()

    var body: some View {
        VStack {
            TextField("Search Songs", text: $searchText, onCommit: {
                // 1
                UIApplication.shared.resignFirstResponder()
                if self.searchText.isEmpty {
                    // 2
                    self.searchResults = []
                } else {
                    // 3
                    SKCloudServiceController.requestAuthorization { (status) in
                        if status == .authorized {
                            // 4
                            self.searchResults = AppleMusicAPI().searchAppleMusic(self.searchText)
                        }
                    }
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 16)
            .accentColor(.pink)
            
            List {
                ForEach(searchResults, id: \.id) {
                    song in
                    HStack {
                        Image(systemName: "rectangle.stack.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(5)
                            .shadow(radius: 2)
                        
                    VStack(alignment: .leading) {
                        Text(song.name)
                                .font(.headline)
                           
                        Text(song.artistName)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button(action: {
                            print("Playing \(song.name)")
                            }) {
                                Image(systemName: "play.fill")
                                    .foregroundColor(.pink)
                            }
                        }
                    }
                }
            .accentColor(.pink)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
