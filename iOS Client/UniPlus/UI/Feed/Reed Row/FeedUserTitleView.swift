//
//  FeedUserTitleView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedUserTitleView: View {
    
    var name: String
    
    var body: some View {
        HStack {
            CircleImage(image: Image("Gellert"), width: 40, height:40)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.custom("SF UI Text Bold", size: 15))
                    .foregroundColor(.white)
                Text("Undergraduate student at UCR")
                    .font(.custom("SF UI Text Regular", size: 11))
                    .foregroundColor(.white)
            }
        }
    }
}

struct FeedUserTitleView_Previews: PreviewProvider {
    static var previews: some View {
        FeedUserTitleView(name: "Jiahe Gellert Li")
    }
}
