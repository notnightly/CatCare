import SwiftUI
import PhotosUI

struct HomeView: View {
    @AppStorage("lastCleaned") private var lastCleaned: Double = 0
    @AppStorage("imageData") private var imageData: Data?
    @State private var selectedPhoto: PhotosPickerItem? = nil

    @State private var showDialog = false
    @State private var openGallery = false
    
    @State private var kajuMood = "😺"
    
    var cleanedRecently: Bool {
        guard lastCleaned > 0 else { return false }
        let lastCleanedDate = Date(timeIntervalSince1970: lastCleaned)
        return Date().timeIntervalSince(lastCleanedDate) < 86400
    }

    var body: some View {
        
        NavigationStack {
            VStack(spacing: 50) {
                ScrollView {
                    VStack {
                        HStack {
                            // Hardcoded, for now
                            VStack(alignment: .leading) {
                                Text("Pune")
                                    .font(.headline)
                                Text("Sunny · 32°C")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("☀️")
                                .font(.largeTitle)
                        }
                        .padding()
                        .background(.yellow.opacity(0.1))
                        .cornerRadius(12)
                        if let imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    showDialog = true
                                }
                        } else {
                            Image("kaju")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    showDialog = true
                                }
                        }
                    }
                    .confirmationDialog("Change the photo?", isPresented: $showDialog) {
                        Button("Choose from Gallery") {
                            openGallery = true
                        }
                    }
                    .photosPicker(isPresented: $openGallery, selection: $selectedPhoto, matching: .images)
                    .onChange(of: selectedPhoto) {
                        Task {
                            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                                imageData = data
                            }
                        }
                    }
                    
                    
                    HStack(spacing: 20) {
                        if cleanedRecently {
                            NavigationLink(destination: LitterBoxView()) {
                                StatCard(title: "Litter", value: "Clean", color: .green)
                            }
                        } else {
                            NavigationLink(destination: LitterBoxView()) {
                                StatCard(title: "Litter", value: "Not clean", color: .red)
                            }
                        }
                        
                        
                        NavigationLink(destination: MoodDiaryView()) {
                            StatCard(title: "Mood", value: "Happy :)", color: .yellow)
                        }
                    }
                }.padding(20)
            }
            
            .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.automatic)
                .scrollIndicators(.hidden)
                
            
        }.padding(.horizontal, 10).contentMargins(2)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .bold()
                .padding(.bottom, 2)

            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(16)
    }
}
