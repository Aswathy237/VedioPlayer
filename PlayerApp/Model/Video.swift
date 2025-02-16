//
//  Video.swift
//  PlayerApp
//
//  Created by 61086256 on 16/02/25.
//

import Foundation

import Foundation

struct Video : Identifiable {
    let id = UUID()
    let title: String
    let episodeName: String
    let description: String
    let videoURL: URL?
    let thumbnailURL: String
    let duration: Double
    let recommendations: [Video]
}

let sampleVideo = Video(
    title: "Speech on Human Rights",
    episodeName: "Episode 1: The Beginning",
    description: "This is for a speech delivered in US for protecting Human Rights .",
    videoURL: Bundle.main.url(forResource: "Speech", withExtension: "mp4"),
    thumbnailURL: "https://media.istockphoto.com/id/1332455278/photo/smiling-white-light-brown-and-dark-brown-teddy-bears-sitting-on-table-at-pink-wall-background.jpg?s=612x612&w=0&k=20&c=vt3NvcLmXOFQQdbp_9_V3ZVlC1Dd47OFk4UEbgDd750=",
    duration: 1200,
    recommendations: [
        Video(title: "Sample Show 2", episodeName: "Episode 1", description: "Another sample.", videoURL: Bundle.main.url(forResource: "BigBuckBunny", withExtension: "mp4"), thumbnailURL: "", duration: 1200, recommendations: [])
    ]
)
