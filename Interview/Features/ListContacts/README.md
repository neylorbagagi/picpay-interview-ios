# ListContacts Framework

A modular Swift framework for displaying and managing a list of contacts in iOS applications.

## Features
- Fetches contacts from a remote API
- Displays contacts in a customizable table view
- Asynchronous image loading with caching
- MVVM architecture
- Easily embeddable in any iOS app

## Usage

### Import the Framework
```swift
import ListContacts
```

### Present the Contacts List
```swift
let contactsVC = ListContacts().build()
// Present or push contactsVC in your navigation stack
```

## Public API
- `ListContacts.build() -> UIViewController`: Returns the main contacts list view controller.

## Customization
- You can customize the appearance and behavior by subclassing or modifying the view models and views.

## Requirements
- iOS 13.0+
- Swift 5.0+

## Installation
- Add the ListContacts framework target to your project.
- Link the framework to your main app target.

## Contributing
Feel free to open issues or submit pull requests for improvements and bug fixes.

## License
MIT License. See [LICENSE](../../../../LICENSE) for details.
