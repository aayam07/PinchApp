//
//  InfoPannelView.swift
//  Pinch
//
//  Created by Aayam Adhikari on 01/08/2023.
//

import SwiftUI

// Reusable view component (smaller view)
struct InfoPannelView: View {
    
    //MARK: - PROPERTY
    
    // to display the scale and offset values of the image in info pannel
    var scale: CGFloat
    var offset: CGSize
    
    // mutable (changable) variable to store the actual state (shown or hidden) of this info pannel
    @State private var isInfoPannelVisible: Bool = false  // hidden by default
    
    
    var body: some View {
        HStack {
            //MARK: - HOTSPOT
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut) {
                        isInfoPannelVisible.toggle()
                    }
                }
            
            Spacer()
            
            //MARK: - INFO PANEL
            HStack(spacing: 2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
//                For string interpolation "\()" in swift
                Text("\(scale)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                
                Spacer()
            }  //: INNER HSTACK
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPannelVisible ? 1 : 0)  // to provide animation
            
        }  //: MAIN HSTACK
    }
}

struct InfoPannelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPannelView(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
}
