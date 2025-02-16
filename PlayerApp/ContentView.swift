//
//  ContentView.swift
//  PlayerApp
//
//  Created by 61086256 on 16/02/25.
//


import SwiftUI
import AVKit

struct ContentView: View {
    @StateObject private var viewModel = VideoPlayerViewModel()
    @State private var selectedTab :String = "Info"
    
     let video: Video
    
    var body: some View {
        VStack {
                   // Video Player
            ZStack(alignment: .topTrailing) {
                VideoPlayer(player: viewModel.player)
                    .frame(height: 300)
                    .onTapGesture {
                        viewModel.showControls.toggle()
                    }
                // Caption Icon on Top of the Video Player
                Button(action: viewModel.toggleCaptions) {
                    Image(systemName: viewModel.isCaptionEnabled ? "captions.bubble.fill" : "captions.bubble")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            HStack {
                Button(action: { selectedTab = "Info" })
                {
                    
                    if selectedTab == "Info" {
                        Text("Info")
                            .padding()
                            .background(selectedTab == "Info" ? Color.white : Color.clear).foregroundColor(.black).cornerRadius(8)
                    }else {
                        Text("Info")
                            .padding()
                            .background(selectedTab != "Info" ? Color.black : Color.clear).foregroundColor(.white).cornerRadius(8)
                    }
                }
                Button(action: { selectedTab = "Insight" })
                {
                    if selectedTab == "Insight" {
                        Text("Insight")
                            .padding()
                            .background(selectedTab == "Insight" ? Color.white : Color.clear).foregroundColor(.black).cornerRadius(8)
                    }else {
                        Text("Insight")
                            .padding()
                            .background(selectedTab != "Insight" ? Color.black : Color.clear).foregroundColor(.white).cornerRadius(8)
                    }
                    
                }
                Button(action: { selectedTab = "Continue Watching" })
                {
                    if selectedTab == "Continue Watching" {
                        Text("Continue Watching")
                            .padding()
                            .background(selectedTab == "Continue Watching" ? Color.white : Color.clear).foregroundColor(.black).cornerRadius(8)
                    }else {
                        Text("Continue Watching")
                            .padding()
                            .background(selectedTab != "Continue Watching" ? Color.black : Color.clear).foregroundColor(.white).cornerRadius(8)
                    }
                }
                .background(.clear)
            }
            .padding()
            // Dynamic Content Based on Selected Button
            Group {
                switch selectedTab {
                case "Info":
                    VStack(alignment: .leading) {
                                                Text(video.title)
                                                    .font(.title)
                                                Text(video.episodeName)
                                                    .font(.subheadline)
                                                Text(video.description)
                                                    .font(.caption)
                                            }
                                            .padding()
                case "Insight":
                    Text("Insight Section: This is where you display insights or analytics about the video.")
                        .padding()
                case "Continue Watching":
                    Text("Continue Watching Section: Helps in resuming the content from where you stopped")
                        .padding()
                 default:
                    EmptyView()
                    
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading).animation(.easeInOut, value: selectedTab)
            // Recommendations
                        Text("Recommendations")
                            .font(.headline)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(video.recommendations) { recommendation in
                                    VStack {
                                        AsyncImage(url: URL(string: recommendation.thumbnailURL)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 100, height: 100)
                                        Text(recommendation.title)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Video Player")
                    .background(Color.black)
                    .preferredColorScheme(.dark)
                    .onAppear {
                        viewModel.loadVideo(url: video.videoURL)
                    }
    }
}

#Preview {
    ContentView(video: Video(
        title: "Sample Show",
        episodeName: "Episode 1: The Beginning",
        description: "This is a sample episode description.",
        videoURL: Bundle.main.url(forResource: "Speech", withExtension: "mp4"),
        thumbnailURL: "https://media.istockphoto.com/id/1332455278/photo/smiling-white-light-brown-and-dark-brown-teddy-bears-sitting-on-table-at-pink-wall-background.jpg?s=612x612&w=0&k=20&c=vt3NvcLmXOFQQdbp_9_V3ZVlC1Dd47OFk4UEbgDd750=",
        duration: 1200,
        recommendations: [
            Video(title: "Sample Show 2", episodeName: "Episode 1", description: "Another sample.", videoURL: Bundle.main.url(forResource: "BigBuckBunny", withExtension: "mp4"), thumbnailURL: "", duration: 1200, recommendations: [])
        ]
    ))
}

