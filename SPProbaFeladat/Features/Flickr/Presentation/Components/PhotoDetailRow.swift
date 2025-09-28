//
//  PhotoDetailRow.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//

import SwiftUI

struct PhotoDetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
