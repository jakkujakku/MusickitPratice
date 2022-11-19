//
//  PlayerView.swift
//  MusicPlayerPratice
//
//  Created by (^ㅗ^)7 iMac on 2022/11/19.
//

import SwiftUI

struct PlayerView: View {
    var body: some View {
        GeometryReader { geometry in
            // 1
            VStack(spacing:24) {
                Divider()
                // 2
                Image(systemName: "a.square")
                    .resizable() // 3
                    .frame(width: geometry.size.width - 24, height: geometry.size.width - 24) // 4
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                VStack(spacing:8) {
                    Text("Song Title")
                        .font(Font.system(.title).bold())
                    Text("Artist Name")
                        .font(.system(.headline))
                }
                
                HStack(spacing: 40) {
                    Button(action: {
                        // 1
                        print("Rewind")
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: 10)
                            Image(systemName: "backward.fill")
                                .foregroundColor(.white)
                                .font(.system(.title))
                        }
                    }
                    
                    Button(action: {
                        // 1
                        print("Pause")
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: 10)
                            Image(systemName:
                                    "pause.fill")
                            .foregroundColor(.white)
                            .font(.system(.title))
                        }
                    }
                    
                    Button(action: {
                        // 1
                        print("Skip")
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: 10)
                            Image(systemName: "forward.fill")
                                .foregroundColor(.white)
                                .font(.system(.title))
                        }
                    }
                }
            }
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
