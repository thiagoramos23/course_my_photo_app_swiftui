//
//  FeedView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 14/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

func screenSize() -> CGSize {
    return UIScreen.main.bounds.size
}

struct Post: Identifiable {
    var id = UUID()
    var show: Bool
    var imageName: String
}

let postData = [
    Post(show: false, imageName: "friends"),
    Post(show: false, imageName: "lake"),
    Post(show: false, imageName: "show"),
    Post(show: false, imageName: "trees"),
    Post(show: false, imageName: "show")
]

struct FeedView: View {
    @State var posts: [Post] = postDataœ
    @State var show: Bool = false
    @State var activeIndex = -1
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBarView(show: self.$show)
                Spacer()
                GeometryReader { reader in
                    ScrollView {
                        ForEach(self.posts.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                CardView(post: self.$posts[index], show: self.$show, activeIndex: self.$activeIndex, index: index)
                                    .offset(y: self.posts[index].show ? -geometry.frame(in: .global).minY + 40 : 0)
                            }
                            .frame(height: 400)
                            .zIndex(self.posts[index].show ? 10 : 0)
                            .offset(x: self.activeIndex != index && self.show ? screenSize().width : 0)
                        }
                        
                    }
                    .offset(y: self.show ? -100 : 0)
                    .frame(height: self.show ? screenSize().height : reader.size.height)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
            }
            
        }
        .statusBar(hidden: self.show ? true : false)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
              FeedView()
                 .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
                 .previewDisplayName("iPhone XS")

              FeedView()
                 .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                 .previewDisplayName("iPhone XS Max")
           }
    }
}

struct NavigationBarView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 8) {
                Button(action: {}) {
                    Image(systemName: "camera")
                    .resizable().frame(width: 25, height: 20)
                }
                .foregroundColor(.black)
                Spacer()
                Text("Instagram")
                    .font(Font.custom("Billabong", size: 26))
                Spacer()
                Button(action: {}) {
                    Image(uiImage: #imageLiteral(resourceName: "friends"))
                    .resizable()
                        .frame(width: 36, height: 36)
                    .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)

                }
                .foregroundColor(.red)
            }
            .padding()
            .background(Color.white)
        }
        .opacity(self.show ? 0 : 1)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}

struct RoundedImageView: View {
    var image: UIImage = #imageLiteral(resourceName: "friends")
    var cornerRadius: CGFloat = 5
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct CardView: View {
    @Binding var post: Post
    @Binding var show: Bool
    @Binding var activeIndex: Int
    var index: Int
    
    var closeButtonView: some View {
        HStack {
            Spacer()
            Button(action: {
                self.post.show.toggle()
                self.show.toggle()
            }) {
                Image(systemName: "xmark.circle").font(.largeTitle)
            }
            .foregroundColor(Color.black)
        }
        .padding(.trailing, 8)
    }
    
    var cardProfileView: some View {
        HStack {
            RoundedImageView()
                .frame(width: 25, height: 25)
                .padding(.leading)
            VStack(alignment: .leading) {
                Text("mille_f").font(.footnote).fontWeight(.bold)
                HStack(alignment: .center) {
                    Text("London, England").font(.footnote).foregroundColor(.secondary)
                    Spacer()
                    Text("2 minutes ago").font(.caption).foregroundColor(.secondary)
                }
            }
            .padding(.trailing)
        }
    }
    
    var actionButtonsView: some View {
        HStack(alignment: .center, spacing: 30) {
            Button(action: {}) {
                HStack {
                    Image(systemName: "heart").font(Font.headline.weight(.semibold))
                    Text("20").font(.caption)
                }
                
            }.foregroundColor(.black)
            Button(action: {}) {
                HStack {
                    Image(systemName: "bubble.right").font(Font.headline.weight(.semibold))
                    Text("17").font(.caption)
                }
                
            }.foregroundColor(.black)
            Spacer()
        }.padding()
    }
    
    var commentsView: some View  {
        VStack {
            GeometryReader { reader in
                ScrollView {
                    ForEach(1...5, id: \.self) { index in
                        VStack(alignment: .leading) {
                            HStack {
                                Image(uiImage: #imageLiteral(resourceName: "friends"))
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .clipShape(Circle())
                                Text("mille_f").font(.footnote).fontWeight(.bold)
                            }
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. fdfdsklf;sddas jdklasjd askljd askljd askljd aklsdj aklsdj askldj askldjaskl djaskld ajskld asjkdla sjdklas djaskl djaskld asjkld asjkdl sajdkl sajdklas djaskl dj")
                                .padding(.leading)
                                .padding(.trailing)
                        }
                    }
                }
                .frame(height: self.show ? reader.size.height - 100 : reader.size.height)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    var body: some View {
        ZStack {
            VStack {
                show ? closeButtonView : nil
                
                cardProfileView
                
                RoundedImageView(image: UIImage(named: post.imageName)!, cornerRadius: 20)
                    .padding(.leading)
                    .padding(.trailing)
                    .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 15, x: 5, y: 10)
                    .frame(width: screenSize().width, height: 300)

                actionButtonsView
                
                show ? commentsView : nil
            }
        }
        .onTapGesture {
            self.post.show.toggle()
            self.show.toggle()
            if self.post.show {
                self.activeIndex = self.index
            } else {
                self.activeIndex = -1
            }
        }
        .frame(height: show ? screenSize().height : 400)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}
