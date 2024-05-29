import SwiftUI

struct CustomTabView: View {
    @State private var showSignInView = true

    var body: some View {
        TabView {
            ProfileView(showSignInView: $showSignInView)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }

            FeedView(showSignInView: $showSignInView)
                .tabItem {
                    Image(systemName: "house")
                    Text("Feed")
                }

            SettingsView(showSignInView: $showSignInView)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}
