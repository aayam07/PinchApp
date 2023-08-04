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
    
    // to change the image offset during image drag gesture
    @State private var imageOffset: CGSize = .zero  // sets width and height both zero
    
    //MARK: - FUNCTION (MEHTODS)
    
    // to avoid repetition of bring back image offset and scale to default values
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1  // to bring back to original scale value
            imageOffset = .zero  // back to original position
        }
    }
    
    //MARK: - CONTENT
    
    var body: some View {
        NavigationView {
            ZStack {
                
                // to make Zstack occupy the whole screen, we put specific view under other layers in this ZStack
                Color.clear  // to move the circle symbol to the top of view
                
                //MARK: - PAGE IMAGE
                
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)  // modifier position matters
//                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(imageScale, anchor: .center)
                //MARK: - 1. DOUBLE TAP ZOOM GESTURE
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5  // scale up
                            }
                        } else {
                            resetImageState()
                        }
                    }
                //MARK: - 2. IMAGE DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                
                                // to provide smooth drag
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation  // stores the translation width and height value of image
                                }
//                                print(imageOffset.width)
                            })
                            .onEnded({ _ in
                                // to bring back image to the original position after drag ends (only when the image is not scaled up or zoomed
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                                
                            })
                    )
                //MARK: - 3. MAGNIFICATION
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    if (imageScale >= 1 && imageScale <= 5) {
                                        imageScale = value
                                    } else if imageScale > 5 {
                                        imageScale = 5
                                    } else if imageScale < 1 {
                                        resetImageState()
                                    }
                                }
                            }
                            .onEnded({ _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
                
            }  //: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
                
            }
            //MARK: - INFO PANNEL
            .overlay(
                InfoPannelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top  // top of ZStack
            )
            
            //MARK: - CONTROLS
            .overlay (
                Group {
                    HStack {
                        
                        // SCALE DOWN
                        Button {
                            // some action
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                }
                                
                                // to ensure that image scale is never less than 1
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        //RESET
                        Button {
                            // some action
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }

                        //SCALE UP
                        Button {
                            // some action
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                }
                                
                                // to ensure that image scale is never greater than 5
                                if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }

                    }  //: CONTROLS
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    
                }
                    .padding(.bottom, 30)
                , alignment: .bottom  // bottom of ZSTACk
            )
            
        }  //: NAVAGATION
        .navigationViewStyle(.stack)  // to avoid using side bar on iPad devices
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
    }
}
