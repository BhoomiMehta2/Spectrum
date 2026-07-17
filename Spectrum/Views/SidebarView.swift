import SwiftUI
import UniformTypeIdentifiers

/// Sidebar view listing built-in and imported themes, with an option to import new ones.
public struct SidebarView: View {
    public var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        List {
            Section(header: Text("Built-in").font(.subheadline).fontWeight(.semibold).foregroundColor(.secondary)) {
                ForEach(viewModel.builtInThemes) { theme in
                    ThemeCard(theme: theme, isSelected: viewModel.selectedTheme.name == theme.name)
                        .onTapGesture {
                            viewModel.selectTheme(theme)
                        }
                }
            }
            .collapsible(false)
            
            if !viewModel.importedThemes.isEmpty {
                Section(header: Text("Imported").font(.subheadline).fontWeight(.semibold).foregroundColor(.secondary)) {
                    ForEach(viewModel.importedThemes) { theme in
                        ThemeCard(theme: theme, isSelected: viewModel.selectedTheme.name == theme.name)
                            .onTapGesture {
                                viewModel.selectTheme(theme)
                            }
                    }
                }
                .collapsible(false)
            }
        }
        .listStyle(.sidebar)
        .safeAreaInset(edge: .bottom) {
            Button(action: {
                viewModel.isImporting = true
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                    Text("Import JSON")
                }
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(16)
        }
    }
}
