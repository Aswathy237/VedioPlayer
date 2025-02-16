//
//  VideoPlayerViewModel.swift
//  PlayerApp
//
//  Created by 61086256 on 16/02/25.
//

import Foundation
import SwiftUI
import AVKit

class VideoPlayerViewModel: ObservableObject {
    @Published var isPlaying = false
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var showControls = true
    @Published var isCaptionEnabled = false
    @Published var isMiniPlayerActive = false
    
    internal var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var subtitleURL: URL?
    
    func loadVideo(url: URL?) {
        guard let videoURL = url else { return }
               playerItem = AVPlayerItem(url: videoURL)
               player = AVPlayer(playerItem: playerItem)
               duration = playerItem?.asset.duration.seconds ?? 0
               //Load subtitle if available
//               if let subtitleURL = Bundle.main.url(forResource: "Speech", withExtension: "vtt") {
//                   self.subtitleURL = subtitleURL
//                   addSubtitles(to: playerItem!)
//               }
    }
    
    func playPause() {
        guard let player = player else { return }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }
    
    func seek(to time: Double) {
        guard let player = player else { return }
        player.seek(to: CMTime(seconds: time, preferredTimescale: 1))
    }
    
    func toggleCaptions() {
        isCaptionEnabled.toggle()
        // Implement caption logic here
        guard let playerItem = playerItem else { return }
        
        if isCaptionEnabled {
            addSubtitles(to: playerItem)
        } else {
            removeSubtitles(from: playerItem)
        }
    }
    private func addSubtitles(to playerItem: AVPlayerItem) {
        guard let subtitleURL = subtitleURL else { return }
        // Create an AVAsset for the subtitle file
        let subtitleAsset = AVURLAsset(url: subtitleURL)
        let subtitleTrack = subtitleAsset.tracks(withMediaType: .text).first
        // Create a mutable composition to add the subtitle track
        let composition = AVMutableComposition()
        guard let compositionTrack = composition.addMutableTrack(withMediaType: .text, preferredTrackID: kCMPersistentTrackID_Invalid) else { return }
        // Add the subtitle track to the composition
        if let subtitleTrack = subtitleTrack { try? compositionTrack.insertTimeRange(subtitleTrack.timeRange, of: subtitleTrack, at: .zero)
        
        }
        // Create a new player item with the composition
        let newPlayerItem = AVPlayerItem(asset: composition)
        player?.replaceCurrentItem(with: newPlayerItem)
    }
    private func removeSubtitles(from playerItem: AVPlayerItem) {
        guard let url = playerItem.asset as? AVURLAsset else { return }
        let newPlayerItem = AVPlayerItem(url: url.url)
        player?.replaceCurrentItem(with: newPlayerItem)
    }
}



