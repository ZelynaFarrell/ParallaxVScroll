//
//  ContentView.swift
//  ParallaxVScroll
//
//  Created by Zelyna Sillas on 1/16/24.
//

import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            header
            ScrollView(.vertical) {
                LazyVStack(spacing: 15) {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                        .font(.subheadline)
                        .kerning(1)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 8)
                    
                    ParallaxImageView(maximumMovement: 155) { size in
                        Image(.NYC)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                    }
                    .shadow(color: .black.opacity(0.55), radius: 1, y: 5)
                    .frame(height: 455)
                    
                    LocationCaption(city: "New York City")
                    
                    ParallaxImageView(maximumMovement: 145) { size in
                        Image(.SF)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                    }
                    .shadow(color: .black.opacity(0.55), radius: 1, y: 5)
                    .frame(height: 475)
                    
                    LocationCaption(city: "San Francisco")
                    
                    ParallaxImageView(maximumMovement: 145) { size in
                        Image(.chicago)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                    }
                    .shadow(color: .black.opacity(0.55), radius: 1, y: 5)
                    .frame(height: 475)
                    
                    LocationCaption(city: "Chicago")
                    
                    ParallaxImageView(maximumMovement: 125) { size in
                        Image(.seattle)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                    }
                    .shadow(color: .black.opacity(0.55), radius: 1, y: 5)
                    .frame(height: 455)
                    
                    LocationCaption(city: "Seattle")
                }
                .padding(.horizontal, 18)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    func LocationCaption(city: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(city)
                .font(.title).bold()
            
            Divider()
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .kerning(1)
                .foregroundStyle(.primary.opacity(0.6))
        }
        .padding(.horizontal, 3)
        .padding(.bottom)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var header: some View {
        VStack {
            Text("Airbnb")
                .font(.largeTitle).bold()
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, -5)
            
            HStack(spacing: 5) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                
                TextField("Where to?", text: $searchText)
                
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.title3)
                    .foregroundStyle(.gray)
            }
            .padding(10)
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
        }
        .padding(13)
        .padding(.bottom, 5)
    }
}

struct ParallaxImageView<Content: View>: View {
    var maximumMovement: CGFloat = 100
    
    @ViewBuilder var content: (CGSize) -> Content
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
            let scrollViewHeight = $0.bounds(of: .scrollView)?.size.height ?? 0
            let maximumMovement = min(maximumMovement, (size.height * 0.35))
            let stretchedSize: CGSize = .init(width: size.width, height: size.height + maximumMovement)
            
            let progress = minY / scrollViewHeight
            let cappedProgress = max(min(progress, 1.0), -1.0)
            let movementOffset = cappedProgress * -maximumMovement
            
            content(size)
                .offset(y: movementOffset)
                .frame(width: stretchedSize.width, height: stretchedSize.height)
                .frame(width: size.width, height: size.height)
            //                .overlay(alignment: .bottom) {
            //                    Text("\(cappedProgress)")
            //                        .font(.largeTitle)
            //                }
                .clipped()
        }
        .cornerRadius(15)
    }
}

#Preview {
    ContentView()
}
