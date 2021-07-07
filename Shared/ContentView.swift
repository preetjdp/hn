//
//  ContentView.swift
//  Shared
//
//  Created by Preet Parekh on 21/02/21.
//

import SwiftUI
import WebKit

struct ScrollViewCleaner: NSViewRepresentable {
    
    func makeNSView(context: NSViewRepresentableContext<ScrollViewCleaner>) -> NSView {
        let nsView = NSView()
        DispatchQueue.main.async { // on next event nsView will be in view hierarchy
            if let scrollView = nsView.enclosingScrollView {
                scrollView.drawsBackground = false
            }
        }
        return nsView
    }
    
    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<ScrollViewCleaner>) {
    }
}

extension View {
    func removingScrollViewBackground() -> some View {
        self.background(ScrollViewCleaner())
    }
}

extension View {
    func tooltip(_ tip: String) -> some View {
        background(GeometryReader { childGeometry in
            TooltipView(tip, geometry: childGeometry) {
                self
            }
        })
    }
}


struct ContentView: View {
    @EnvironmentObject var store: Store
    
    @State var selection: Set<Int> = [0]
    @State var showComposeWindow = false
    @State var showSearchBar = false
    @State var search_term = "";
    @State private var showPicker = false
    
    @State var searchBarWidth: CGFloat = 0
    
    var body: some View {
        NavigationView {
            NavBarView()
                .frame(minWidth: 250, idealWidth: 250, maxHeight: .infinity)
            //            PostView()
        }
        .navigationTitle("Hacker News Reader")
        .toolbar {
            
            ToolbarItem(placement: .navigation) {
                Button(action: {
                    store.refresh()
                    
                }) {
                    Image(systemName: "arrow.clockwise")
                }
                //                .scaleEffect(!showSearchBar ? 1 : 0)
                //                .animation(.easeOut)
            }
            
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar) {
                    Image(systemName: "sidebar.left")
                }
            }
            
            //            ToolbarItem(placement: .navigation) {
            //                Button(action: {
            //                    //                    self.showSearchBar.toggle()
            //
            //                }) {
            //                    Image(systemName: "magnifyingglass")
            //                }
            //                //                .scaleEffect(!showSearchBar ? 1 : 0)
            //                //                .animation(.easeOut)
            //            }
            //
            //            ToolbarItem(placement: .navigation) {
            //                //                if showSearchBar {
            //                TextField("Search", text: $search_term)
            //                    .textFieldStyle(RoundedBorderTextFieldStyle())
            //                    //                    .frame(width: showSearchBar ? 100 : 0)
            //                    .frame(width: 120)
            //                    .animation(.easeOut)
            //
            //
            //                //                }
            //            }
            
            ToolbarItem(placement: .automatic) {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                }
            }
            
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    self.showSearchBar.toggle()
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            
            
            //            ToolbarItem(placement: .automatic) {
            //                Button(action: {self.showComposeWindow = true}) {
            //                    Image(systemName: "info.circle")
            //                }.popover(isPresented: $showComposeWindow) {
            //                    Compose(showComposeWindow: $showComposeWindow)
            //                }
            //            }
            
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    self.showPicker = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
                
            }
        }.overlay(SharingsPicker(isPresented: $showPicker, sharingItems: ["https://google.com "]),alignment: .center)
    }
}

struct Compose: View {
    @Binding var showComposeWindow: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(Color.white)
                    .opacity(0.7)
                    .font(.system(size: 40))
                Text("Built By Preet Parekh")
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Divider()
            HStack {
                Image(systemName: "camera")
                Spacer()
                Image(systemName: "photo")
                Spacer()
                Image(systemName: "chart.bar.xaxis")
                Spacer()
                Image(systemName: "mappin.and.ellipse")
            }
            .font(.title3)
            .foregroundColor(.secondary)
            .padding()
        }
    }
}

struct NavBarView: View {
    @State private var isLoading = false
    @State private var favoriteColor = 0
    
    var body: some View {
        TabView {
            NewPostsView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("New")
                }
//            PastPostsView()
//                .tabItem {
//                    Image(systemName: "2.square.fill")
//                    Text("Past")
//                }
            ShowPostsView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Show")
                }
            //            Text("Past")
            //                .tabItem {
            //                    Image(systemName: "2.square.fill")
            //                    Text("Past")
            //                }
            //            Text("Show")
            //                .tabItem {
            //                    Image(systemName: "3.square.fill")
            //                    Text("Show")
            //                }
        }
        .font(.headline)
        //        VStack {
        //            VStack {
        //                Picker("", selection: $favoriteColor) {
        //                    Text("New").tag(0)
        //                    Text("Past").tag(1)
        //                    Text("Show").tag(2)
        //                }
        //                .pickerStyle(SegmentedPickerStyle())
        //                .labelsHidden()
        //
        ////                Spacer()
        ////
        ////                Button("Toggle") {
        ////                    isLoading.toggle()
        ////                }
        //            }
        //            .padding(20)
        //            .frame(height: 100, alignment: .center)
        
        //            Divider()
        
        //            VStack {
        //                if isLoading {
        //                    ProgressView()
        //                } else {
        //                    List() {
        //                        ForEach((1...1000).reversed(), id: \.self) {
        //                            symbol in Module(title: "Stand Hours", value: "6", subtitle: "hr")
        //                        }
        //                    }.frame(minWidth: 200, alignment: .center)
        //                    .padding(0)
        //                }
        //            }.frame(maxHeight: .infinity, alignment: .center)
        //        }.frame(maxWidth: .infinity)
    }
}

struct NewPostsView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ZStack {
            if store.newPosts.count == 0 {
                List(store.placeholderPosts){
                    post in PostComponent(post: post)
                }
                .redacted(reason: .placeholder)
                .listStyle(SidebarListStyle())
            } else {
                List(store.newPosts){
                    post in PostComponent(post: post)
                }
                .listStyle(SidebarListStyle())
            }
        }.onAppear {
            store.getNewPosts()
        }
    }
}

struct PastPostsView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ZStack {
            if store.pastPosts.count == 0 {
                List(store.placeholderPosts){
                    post in PostComponent(post: post)
                }
                .redacted(reason: .placeholder)
                .listStyle(SidebarListStyle())
            } else {
                List(store.pastPosts){
                    post in PostComponent(post: post)
                }
                .listStyle(SidebarListStyle())
            }
        }.onAppear {
            store.getPastPosts()
        }
    }
}

struct ShowPostsView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ZStack {
            if store.showPosts.count == 0 {
                List(store.placeholderPosts){
                    post in PostComponent(post: post)
                }
                .redacted(reason: .placeholder)
                .listStyle(SidebarListStyle())
            } else {
                List(store.showPosts){
                    post in PostComponent(post: post)
                }
                .listStyle(SidebarListStyle())
            }
        }.onAppear {
            store.getShowPosts()
        }
    }
}


struct PostComponent: View {
    @State var post: Post;
    
    var body: some View {
        NavigationLink(destination: PostView(post: post)) {
            VStack(alignment: .leading) {
                Text(post.title).font(.headline)
                //                Text("This is a test desc").font(.body)
                if post.by != nil {
                    Text("by \(post.by!)").font(.footnote)
                }
            }
            .navigationTitle(post.title)
            .padding(.vertical, 8)
//            .help(post.title)
            .tooltip(post.title)
        }
    }
}

struct PostView: View {
    @State var post: Post;
    
    var body: some View {
        //        Text("Dogecoin to the Moon 🚀")
        //            .padding()
        if post.url != nil {
            SafariWebView(mesgURL: post.url!)
        }
        
        
    }
}

struct SafariWebView: View {
    @ObservedObject var model: WebViewModel
    
    init(mesgURL: String) {
        //Assign the url to the model and initialise the model
        self.model = WebViewModel(link: mesgURL)
    }
    
    var body: some View {
        //Create the WebView with the model
        SwiftUIWebView(viewModel: model)
    }
}

class WebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    @Published var pageTitle: String
    
    init (link: String) {
        self.link = link
        self.pageTitle = ""
    }
}

struct SwiftUIWebView: NSViewRepresentable {
    
    public typealias NSViewType = WKWebView
    @ObservedObject var viewModel: WebViewModel
    
    private let webView: WKWebView = WKWebView()
    public func makeNSView(context: NSViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator as? WKUIDelegate
        webView.load(URLRequest(url: URL(string: viewModel.link)!))
        return webView
    }
    
    public func updateNSView(_ nsView: WKWebView, context: NSViewRepresentableContext<SwiftUIWebView>) { }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel
        
        init(_ viewModel: WebViewModel) {
            //Initialise the WebViewModel
            self.viewModel = viewModel
        }
        
        public func webView(_: WKWebView, didFail: WKNavigation!, withError: Error) { }
        
        public func webView(_: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError: Error) { }
        
        //After the webpage is loaded, assign the data in WebViewModel class
        public func webView(_ web: WKWebView, didFinish: WKNavigation!) {
            self.viewModel.pageTitle = web.title!
            self.viewModel.link = web.url?.absoluteString ?? "https://google.com"
            self.viewModel.didFinishLoading = true
        }
        
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) { }
        
        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
