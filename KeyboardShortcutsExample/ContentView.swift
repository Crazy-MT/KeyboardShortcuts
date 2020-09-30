import SwiftUI
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
	static let testShortcut1 = Self("testShortcut1")
	static let testShortcut2 = Self("testShortcut2")
}

struct ContentView: View {
	@State private var isPressed1 = false
	@State private var isPressed2 = false
	@State var path1: String = ""
	@State var path2: String = ""
	@State var selectedURL: URL?
	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				HStack {
					KeyboardShortcuts.Recorder(for: .testShortcut1)
						.padding(.trailing, 10)
					Text("Pressed? \(isPressed1 ? "👍" : "👎") \(path1)")
						.frame(minWidth: 100, alignment: .leading)
					
					Button(action: {
						let panel = NSOpenPanel()
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
							let result = panel.runModal()
							if result == .OK {
								self.selectedURL = panel.url
								path1 = self.selectedURL!.path
							}
						}
					}) {
						Text("Select Software or Script")
					}
				}
				HStack {
					KeyboardShortcuts.Recorder(for: .testShortcut2)
						.padding(.trailing, 10)
					Text("Pressed? \(isPressed2 ? "👍" : "👎") \(path2)")
						.frame(minWidth: 100, alignment: .leading)
					Button(action: {
						let panel = NSOpenPanel()
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
							let result = panel.runModal()
							if result == .OK {
								self.selectedURL = panel.url
								path2 = self.selectedURL!.path
							}
						}
					}) {
						Text("Select Software or Script")
					}
				}
			}.padding(60)
			Divider()
			Button("Reset All") {
				KeyboardShortcuts.reset(.testShortcut1, .testShortcut2)
			}
			.frame(minWidth: 300)
			.padding(60)
			.onAppear {
				KeyboardShortcuts.onKeyDown(for: .testShortcut1) {
					isPressed1 = true
					
					runSoftOrScript(path: path1)
				}

				KeyboardShortcuts.onKeyUp(for: .testShortcut1) {
					isPressed1 = false
				}

				KeyboardShortcuts.onKeyDown(for: .testShortcut2) {
					isPressed2 = true
					
					runSoftOrScript(path: path2)
				}

				KeyboardShortcuts.onKeyUp(for: .testShortcut2) {
					isPressed2 = false
				}
			}
		}
	}
}

private func runSoftOrScript(path: String) {
	if path.contains(".app") {
		let appPath = path
		NSWorkspace.shared.openFile(appPath) // "/Applications/WeChat.app/"
	}
	
	if path.contains(".sh") {
		let task = Process()
		task.launchPath = path //"/Users/mt/project/KeyboardShortcuts/makeandroid.sh"
		task.launch()
		task.waitUntilExit()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
