//
//  PlayerAppApp.swift
//  PlayerApp
//
//  Created by 61086256 on 16/02/25.
//

import SwiftUI

@main
struct PlayerAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(video: Video(
                title: "Sample Show",
                episodeName: "Episode 1: The Beginning",
                description: "This is a sample episode description.",
                videoURL: Bundle.main.url(forResource: "BigBuckBunny", withExtension: "mp4"),
                thumbnailURL: "https://media.istockphoto.com/id/1332455278/photo/smiling-white-light-brown-and-dark-brown-teddy-bears-sitting-on-table-at-pink-wall-background.jpg?s=612x612&w=0&k=20&c=vt3NvcLmXOFQQdbp_9_V3ZVlC1Dd47OFk4UEbgDd750=",
                duration: 1200,
                recommendations: [
                    Video(title: "Sample Show 2", episodeName: "Episode 1", description: "Another sample.", videoURL: Bundle.main.url(forResource: "BigBuckBunny", withExtension: "mp4"), thumbnailURL: "", duration: 1200, recommendations: [])
                ]
            ))
        }
    }
}
