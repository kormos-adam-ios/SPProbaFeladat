# SPProbaFeladat

iOS app (SwiftUI) showcasing Flickr photo search and details with a clean architecture split into `Presentation`, `Domain`, and `Data` layers.

- Author: Kormos Ádám
- Minimum iOS: 17.0
- Xcode: 26

## Features

- Search photos on Flickr and view details
- Clean separation of layers
- Simple DI factories per feature
- Image loading via Kingfisher

## Requirements

- Xcode 26
- iOS 17.0+
- Swift (Xcode 26 toolchain)

## Swift Package Manager dependencies

- Kingfisher  
  URL: https://github.com/onevcat/Kingfisher

- LazyPager  
  URL: https://github.com/gh123man/SwiftUI-LazyPager

Add via Xcode:
- Xcode → File → Add Package Dependencies…
- Enter the URL above and select the latest release
- Add to the app target

## Project structure (high level)

- `App/` — app entry
- `Core/` — shared types, networking, and extensions
- `Features/Flickr/` — Flickr feature (Configuration, Data, Domain, DI, Presentation)
- `Resources/` — assets
- `Tests/` — unit and UI tests

## Flickr API key setup

Create a secrets plist so the app can authenticate with Flickr.

1) Create the file
- In Xcode, right‑click `Features/Flickr/Configuration/` → New File… → Property List
- Name it `flickr_secret.plist`

2) Add the required key
- Add a String key named `flickr_api_key`
- Set its value to your Flickr API key

Example contents:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>flickr_api_key</key>
    <string>YOUR_FLICKR_API_KEY_HERE</string>
</dict>
</plist>
