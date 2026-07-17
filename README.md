# Spectrum 🎨

**Spectrum** is a native macOS application built with SwiftUI that allows developers to seamlessly import, preview, and apply VS Code themes directly to Xcode with a single click.

No more manual plist editing, color parsing, or downloading zip files. Just search, select, and code in style.

---

## Features ✨

- **VS Code Marketplace Search**: Query the official VS Code Extension Gallery directly inside the app, download extension packs, and import them in the background.
- **Auto-Suffix Collisions**: Easily import extension packs (like *Doki Theme* or *Catppuccin*) containing multiple variants. Duplicate names are automatically resolved without crashing the app.
- **Xcode Automatic Preferences Integration**: Installing a theme automatically runs a background process updating `XCFontAndColorCurrentTheme` and `XCFontAndColorCurrentDarkTheme` preferences. The theme will be active immediately upon Xcode restart!
- **Local Database Persistence**: All imported custom themes are safely persisted locally on your disk (`~/Library/Application Support/Spectrum`) and reloaded automatically upon launch.
- **No Third-Party Bloat**: Built purely with native macOS commands (`/usr/bin/unzip`, `sips`, and `defaults`) avoiding heavy third-party framework dependencies.
- **Universal Binary Support**: Native execution for both Intel (`x86_64`) and Apple Silicon (`arm64`) Macs.

---

## Installation & How to Run 🛠️

### 1. Build using Xcode
1. Open the project folder or double-click `ThemeForge.xcodeproj` in Xcode.
2. Select the target **Spectrum** and press **Cmd + R** to run it.
3. To copy the application to your applications folder, select **Product -> Archive** in Xcode, or build it using the command-line helper.

### 2. Build via Command Line
Run the helper project compiler script to build a Release configuration directly into your `/Applications` directory:
```bash
# 1. Regenerate Xcode project
python3 generate_xcodeproj.py

# 2. Build and install to applications folder
xcodebuild -project ThemeForge.xcodeproj -scheme Spectrum -configuration Release build CONFIGURATION_BUILD_DIR=build
rm -rf /Applications/Spectrum.app
cp -R build/Spectrum.app /Applications/Spectrum.app
rm -rf build
killall Finder && killall Dock
```

---

## Usage Guide 📖

1. **Import a Theme**: 
   - Click **Import JSON** at the bottom of the sidebar.
   - Go to the **Search Marketplace** tab, type a search keyword (e.g., `Tokyo Night` or `Doki Theme`), and press Enter.
   - Click **Get** to download and unpack all themes.
2. **Preview**: Click any theme in your **Imported** sidebar section to preview syntax highlighting on a Swift code editor mockup.
3. **Install**: Click **Install to Xcode** at the top right, restart Xcode, and start coding!

---

## Technical Details ⚙️

- **Framework**: SwiftUI (using the Swift 5.9 `@Observable` system).
- **Format Conversion**: Converts VS Code JSON tokens (including hex cleaning) into standard Xcode `.xccolortheme` XML configuration keys.
- **Persistence Directory**: `~/Library/Application Support/Spectrum/ImportedThemes/themes.json`

---

## License 📄

This project is open-source and available under the [MIT License](LICENSE).
