//
//  ContentView.swift
//  Pinch
//
//  Created by Aayam Adhikari on 30/07/2023.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTY
    
    // to apply implicit animation to main image when launching the home page
    @State private var isAnimating: Bool = false
    
    // to store the actual value of the image scale for double tap gesture
    @State private var imageScale: CGFloat = 1
    
    //MARK: - FUNCTION
    
    //MARK: - CONTENT
    
    var body: some View {
        NavigationView {
            ZStack {
                
                //MARK: - PAGE IMAGE
                
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(imageScale, anchor: .center)
                //MARK: - DOUBLE TAP ZOOM GESTURE
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5  // scale up
                            }
                        } else {
                            withAnimation(.spring()) {
                                imageScale = 1  // back to default scale value
                            }
                        }
                    }
            }
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isAnimating = true
            }
            
        }  //: NAVAGATION
        .navigationViewStyle(.stack)  // to avoid using side bar on iPad devices
        
        
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
