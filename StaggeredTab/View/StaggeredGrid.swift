//
//  StaggeredGrid.swift
//  StaggeredTab
//
//  Created by 공현택 on 2021/10/30.
//

import SwiftUI

// Custom View Builder....

// T -> is to hold the identifiable collection of data


struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    
    // It will return each object from collection to build View ...
    var content: (T) -> Content
    
    var list: [T]

    // Colums...
    var columns: Int
    
    // properties
    var showsIndicators: Bool
    var spacing: CGFloat
    
    init(columns: Int, showsIndicators: Bool = false, spacing: CGFloat = 10.0, list: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
        self.list = list
        self.showsIndicators = showsIndicators
        self.spacing = spacing
        self.columns = columns
    }
    
    // Staggered Grid Function...
    func setupList() -> [[T]] {
        
        // creating empty sub arrays of columns count ...
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        // spiliting array for Vstack oriented View ...
        var currentIndex = 0
        
        for object in list {
            gridArray[currentIndex].append(object)
            
            // increasing index count...
            // and resetting if overbounds the columns count...
            if currentIndex == (columns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: showsIndicators) {
            HStack(alignment: .top) {
                
                ForEach(setupList(), id: \.self) { columnsData in
                    
                    
                    // For Optimized Using LazyStack...
                    LazyVStack(spacing: spacing) {
                        
                        ForEach(columnsData) { object in
                            content(object)
                        }
                    }
                }
                
            }
            // only vertical padding...
            // horizontal padding will be user's optional...
            .padding(.vertical)
        }
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
