import ProjectDescription

let project = Project(
    name: "IceCubesApp",
    targets: [
        .target(
            name: "IceCubesApp",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.IceCubesApp",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["IceCubesApp/App/**"],
            resources: [
                "IceCubesApp/Embeds/**",
                "IceCubesApp/Assets.xcassets",
                "IceCubesApp/Resources/Preview Assets.xcassets",
            ],
            dependencies: [
                .external(name: "Account"),
                .external(name: "AppAccount"),
                .external(name: "Conversations"),
                .external(name: "DesignSystem"),
                .external(name: "Env"),
                .external(name: "Explore"),
                .external(name: "Lists"),
                .external(name: "MediaUI"),
                .external(name: "Models"),
                .external(name: "Network"),
                .external(name: "Notifications"),
                .external(name: "StatusKit"),
                .external(name: "Timeline"),
                .external(name: "RevenueCat"),
                .external(name: "SFSafeSymbols"),
            ]
        ),
    ]
)
