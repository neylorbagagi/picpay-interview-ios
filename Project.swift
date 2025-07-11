import ProjectDescription

let project = Project(
    name: "Interview",
    targets: [
        .target(
            name: "Interview",
            destinations: .iOS,
            product: .app,
            bundleId: "com.suaorganizacao.interview",
            infoPlist: .file(path: "Interview/Info.plist"),
            sources: ["Interview/Sources/**"],
            resources: ["Interview/Resources/**"],
            // , "Interview/Resources/AppDelegate.swift", "Interview/Resources/SceneDelegate.swift"
            dependencies: [
                .target(name: "ListContacts"),
                .target(name: "FeatureFoundation")
            ]
        ),
        .target(
            name: "ListContacts",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.suaorganizacao.listcontacts",
            infoPlist: .file(path: "Interview/Features/ListContacts/ListContacts-Info.plist"),//.default,
            sources: ["Interview/Features/ListContacts/Sources/**"],
            dependencies: [
                .target(name: "FeatureFoundation")
            ]
        ),
        .target(
            name: "ListContactsTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.suaorganizacao.listcontactsTests",
            infoPlist: .file(path: "Interview/Features/ListContacts/Tests/ListContactsTests-Info.plist"),
            sources: ["Interview/Features/ListContacts/Tests/Sources/**"],
            dependencies: [
                .target(name: "ListContacts")
            ]
        ),
        .target(
            name: "FeatureFoundation",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.suaorganizacao.featurefoundation",
            infoPlist: .file(path: "Interview/Plataform/FeatureFoundation/FeatureFoundation-Info.plist"),
            sources: ["Interview/Plataform/FeatureFoundation/Sources/**"],
            dependencies: []
        )
    ]
)
