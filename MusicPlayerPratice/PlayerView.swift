//
//  PlayerView.swift
//  MusicPlayerPratice
//
//  Created by (^ㅗ^)7 iMac on 2022/11/19.
//

import SwiftUI
import MediaPlayer
import SDWebImageSwiftUI

struct PlayerView: View {
    @Binding var currentSong: Song
    @Binding var musicPlayer: MPMusicPlayerController
    @State private var isPlaying = false
    
    var body: some View {
        GeometryReader { geometry in
            // 1
            VStack(spacing:24) {
                Divider()
                // 2
                WebImage(url: URL(string: self.currentSong.artworkURL.replacingOccurrences(of: "{w}", with: "\(Int(geometry.size.width - 24) * 2)").replacingOccurrences(of: "{h}", with: "\(Int(geometry.size.width - 24) * 2)")))
                    .resizable()
                    .frame(width: geometry.size.width - 24, height: geometry.size.width - 24)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                VStack(spacing: 8) {
                    Text(self.musicPlayer.nowPlayingItem?.title ?? "Not Playing")
                        .font(Font.system(.title).bold())
                    Text(self.musicPlayer.nowPlayingItem?.artist ?? "")
                        .font(.system(.headline))
                }
                
                HStack(spacing: 40) {
                    Button(action: {
                        // 1
                        if self.musicPlayer.currentPlaybackTime < 5 {
                            self.musicPlayer.skipToPreviousItem()
                        } else {
                            self.musicPlayer.skipToBeginning()
                        }
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
                        if self.musicPlayer.playbackState == .paused || self.musicPlayer.playbackState == .stopped {
                            self.musicPlayer.play()
                            // 1
                            self.isPlaying = true
                        } else {
                            self.musicPlayer.pause()
                            // 2
                            self.isPlaying = false
                        }
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: 10)
                            Image(systemName: self.isPlaying ? "pause.fill" : "play.fill")
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
        .onAppear() {
            if self.musicPlayer.playbackState == .playing {
                self.isPlaying = true
            } else {
                self.isPlaying = false
            }
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
