import Foundation
import AppKit

/// Service handling theme installation into Xcode's FontAndColorThemes folder.
public final class ThemeInstaller {
    
    /// Installs the xccolortheme file to Xcode and returns true if Xcode is currently running (requiring a restart).
    public static func install(themeName: String, xmlContent: String) throws -> Bool {
        let fileManager = FileManager.default
        
        // Resolve path: ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
        guard let libraryURL = fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first else {
            throw NSError(
                domain: "ThemeInstaller",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Could not locate the User Library directory. Please check disk permissions."]
            )
        }
        
        let fontAndColorThemesURL = libraryURL
            .appendingPathComponent("Developer")
            .appendingPathComponent("Xcode")
            .appendingPathComponent("UserData")
            .appendingPathComponent("FontAndColorThemes")
        
        // Create directory recursively if it doesn't exist
        if !fileManager.fileExists(atPath: fontAndColorThemesURL.path) {
            try fileManager.createDirectory(at: fontAndColorThemesURL, withIntermediateDirectories: true)
        }
        
        let destinationURL = fontAndColorThemesURL.appendingPathComponent("\(themeName).xccolortheme")
        
        // Write xccolortheme XML content
        try xmlContent.write(to: destinationURL, atomically: true, encoding: .utf8)
        
        // Automatically set as Xcode active editor theme (both light & dark settings) using CoreFoundation preferences
        let domain = "com.apple.dt.Xcode" as CFString
        let themeFile = "\(themeName).xccolortheme" as CFString
        
        CFPreferencesSetAppValue("XCFontAndColorCurrentTheme" as CFString, themeFile, domain)
        CFPreferencesSetAppValue("XCFontAndColorCurrentDarkTheme" as CFString, themeFile, domain)
        CFPreferencesAppSynchronize(domain)
        
        // Check if Xcode is currently running
        let isXcodeRunning = NSWorkspace.shared.runningApplications.contains { app in
            app.bundleIdentifier == "com.apple.dt.Xcode"
        }
        
        return isXcodeRunning
    }
}
