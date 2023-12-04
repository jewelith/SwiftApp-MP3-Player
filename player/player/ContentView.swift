//
//  ContentView.swift
//  player
//
//  Created by Jewelith Thomas on 30/11/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var selectedFilePath: String?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying: Bool = false

    var body: some View {
        VStack {
            Button("Upload MP3") {
                openFilePicker()
            }
            .padding()

            if let path = selectedFilePath {
                Text("Selected File: \(path)")
                    .padding()

                HStack {
                    Button(action: {
                        isPlaying.toggle()
                        if isPlaying {
                            playAudio()
                        } else {
                            pauseAudio()
                        }
                    }) {
                        Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                            .font(.system(size: 30))
                    }
                    .padding()

                    Button("Stop") {
                        stopAudio()
                    }
                    .padding()
                }
            }
        }
    }

    func openFilePicker() {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["mp3"]
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = false

        openPanel.begin { response in
            if response == .OK, let selectedFileURL = openPanel.url {
                selectedFilePath = selectedFileURL.path
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: selectedFileURL)
                } catch {
                    print("Error creating AVAudioPlayer: \(error.localizedDescription)")
                }
            }
        }
    }

    func playAudio() {
        audioPlayer?.play()
    }

    func pauseAudio() {
        audioPlayer?.pause()
    }

    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        isPlaying = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
