//
//  UserView.swift
//  gitinfo
//
//  Created by Anton on 10/12/22.
//

import SwiftUI
import MapKit

struct MapView: View
{
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.165_000, longitude: 61.399_750),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )

    var body: some View
    {
        Map(coordinateRegion: $region)
    }
}

struct UserView: View
{
    var userInfo: UserOwnInfo
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            VStack
            {
                MapView()
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 200)

                AsyncImage(url: userInfo.avatarUrl)
                {
                    image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                placeholder:
                {
                    Image(systemName: "person.crop.rectangle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                    .overlay {
                        Circle().stroke(.gray, lineWidth: 4)
                    }
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .shadow(radius: 6.0)
                    .padding()
                    .offset(y: -130)
                    .padding(.bottom, -130)

                VStack(alignment: .leading)
                {
                    Text(userInfo.name ?? "...")
                        .font(.title)

                    HStack
                    {
                        Text(userInfo.email ?? "...")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Text(userInfo.location ?? "...")
                            .font(.subheadline)
                    }

                    Divider()

                    Text("About")
                        .font(.title2)
                    Text(userInfo.bio ?? "...")
                }
                .padding()

                Spacer()
            }
            .background(Color("darkGlossyGray"))
            .padding(2)
            .cornerRadius(12.0)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userInfo: UserOwnInfo(id: 1, login: "kant", avatarUrl: Foundation.URL(string: "https://avatars.githubusercontent.com/u/914515?v=4")!, name: "Anton", location: "Moskow", email: "at@ya.ru", bio: "info..."))
    }
}
