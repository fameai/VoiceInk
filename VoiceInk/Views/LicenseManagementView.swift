import SwiftUI

struct LicenseManagementView: View {
    @Environment(\.colorScheme) private var colorScheme
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Hero Section
                heroSection

                // Main Content
                VStack(spacing: 32) {
                    aboutContent
                }
                .padding(32)
            }
        }
        .background(Color(NSColor.controlBackgroundColor))
    }

    private var heroSection: some View {
        VStack(spacing: 24) {
            // App Icon
            AppIconView()

            // Title Section
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Image(systemName: "waveform.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(.blue)

                    HStack(alignment: .lastTextBaseline, spacing: 8) {
                        Text("VoiceInk")
                            .font(.system(size: 32, weight: .bold))

                        Text("v\(appVersion)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 4)
                    }
                }

                Text("Free & Open Source Voice-to-Text")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                // Quick Links
                HStack(spacing: 40) {
                    Button {
                        if let url = URL(string: "https://github.com/Beingpax/VoiceInk") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        featureItem(icon: "chevron.left.forwardslash.chevron.right", title: "Source Code", color: .purple)
                    }
                    .buttonStyle(.plain)

                    Button {
                        if let url = URL(string: "https://github.com/Beingpax/VoiceInk/releases") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        featureItem(icon: "list.bullet.clipboard.fill", title: "Changelog", color: .blue)
                    }
                    .buttonStyle(.plain)

                    Button {
                        if let url = URL(string: "https://discord.gg/xryDy57nYD") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        featureItem(icon: "bubble.left.and.bubble.right.fill", title: "Discord", color: .indigo)
                    }
                    .buttonStyle(.plain)

                    Button {
                        if let url = URL(string: "https://tryvoiceink.com/docs") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        featureItem(icon: "book.fill", title: "Docs", color: .orange)
                    }
                    .buttonStyle(.plain)

                    Button {
                        if let url = URL(string: "https://buymeacoffee.com/beingpax") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        animatedTipJarItem()
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 8)
            }
        }
        .padding(.vertical, 60)
    }

    private var aboutContent: some View {
        VStack(spacing: 32) {
            // Features Card
            VStack(spacing: 24) {
                HStack {
                    Image(systemName: "sparkles")
                        .font(.system(size: 20))
                        .foregroundStyle(.blue)
                    Text("Features")
                        .font(.headline)
                    Spacer()
                }

                VStack(alignment: .leading, spacing: 12) {
                    featureRow(icon: "brain.head.profile", title: "Local AI Transcription", description: "Fast, private voice-to-text using Whisper models")
                    featureRow(icon: "wand.and.stars", title: "AI Enhancement", description: "Optional cloud AI to improve your transcriptions")
                    featureRow(icon: "keyboard", title: "Global Hotkeys", description: "Record from anywhere with customizable shortcuts")
                    featureRow(icon: "sparkles.square.fill.on.square", title: "Power Mode", description: "Context-aware settings per app or website")
                    featureRow(icon: "lock.shield", title: "Privacy First", description: "Your audio stays on your device")
                }
            }
            .padding(32)
            .background(CardBackground(isSelected: false))
            .shadow(color: .black.opacity(0.05), radius: 10)

            // Support Card
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.pink)
                    Text("Support Development")
                        .font(.headline)
                    Spacer()
                }

                Text("VoiceInk is free and open source. If you find it useful, consider supporting continued development.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 12) {
                    Button(action: {
                        if let url = URL(string: "https://buymeacoffee.com/beingpax") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        Label("Buy Me a Coffee", systemImage: "cup.and.saucer.fill")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.borderedProminent)

                    Button(action: {
                        if let url = URL(string: "https://github.com/Beingpax/VoiceInk") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        Label("Star on GitHub", systemImage: "star.fill")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(32)
            .background(CardBackground(isSelected: false))
            .shadow(color: .black.opacity(0.05), radius: 10)

            // Credits Card
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.green)
                    Text("Credits")
                        .font(.headline)
                    Spacer()
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Created by Prakash Joshi Pax")
                        .font(.subheadline)

                    Text("Built with Whisper.cpp and SwiftUI")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text("Licensed under MIT License")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(32)
            .background(CardBackground(isSelected: false))
            .shadow(color: .black.opacity(0.05), radius: 10)
        }
    }

    private func featureItem(icon: String, title: String, color: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(color)

            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.primary)
        }
    }

    private func featureRow(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(.blue)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }

    @State private var heartPulse = false

    private func animatedTipJarItem() -> some View {
        HStack(spacing: 8) {
            Image(systemName: "heart.fill")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.pink)
                .scaleEffect(heartPulse ? 1.3 : 1.0)
                .animation(
                    Animation.easeInOut(duration: 1.2)
                        .repeatForever(autoreverses: true),
                    value: heartPulse
                )
                .onAppear {
                    heartPulse = true
                }

            Text("Tip Jar")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.primary)
        }
    }
}
