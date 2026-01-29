import Foundation
import AVFoundation

/// Centralized permission checking with UserDefaults fallback for macOS caching issues.
/// macOS caches permission results (especially AXIsProcessTrusted) and may return stale values
/// even after the user grants permission. This helper uses UserDefaults to track when
/// permissions were actually granted, providing a reliable fallback.
enum PermissionHelper {

    // MARK: - UserDefaults Keys

    static let accessibilityPermissionKey = "accessibilityPermissionGranted"
    static let screenRecordingPermissionKey = "screenRecordingPermissionGranted"

    // MARK: - Accessibility Permission

    /// Check if accessibility permission is granted, with UserDefaults fallback for macOS caching issues.
    static var hasAccessibilityPermission: Bool {
        if AXIsProcessTrusted() {
            // Update cache when we detect permission is granted
            markAccessibilityPermissionGranted()
            return true
        }
        // Fall back to cached value for macOS permission caching issues
        return UserDefaults.standard.bool(forKey: accessibilityPermissionKey)
    }

    /// Mark accessibility permission as granted in UserDefaults cache.
    /// Call this after successfully detecting the permission was granted.
    static func markAccessibilityPermissionGranted() {
        UserDefaults.standard.set(true, forKey: accessibilityPermissionKey)
    }

    /// Clear the cached accessibility permission state.
    /// Call this if you need to reset the permission state (e.g., during testing or if user revokes permission).
    static func clearAccessibilityPermissionCache() {
        UserDefaults.standard.removeObject(forKey: accessibilityPermissionKey)
    }

    // MARK: - Screen Recording Permission

    /// Check if screen recording permission is granted, with UserDefaults fallback for macOS caching issues.
    static var hasScreenRecordingPermission: Bool {
        if CGPreflightScreenCaptureAccess() {
            // Update cache when we detect permission is granted
            markScreenRecordingPermissionGranted()
            return true
        }
        // Fall back to cached value for macOS permission caching issues
        return UserDefaults.standard.bool(forKey: screenRecordingPermissionKey)
    }

    /// Mark screen recording permission as granted in UserDefaults cache.
    /// Call this after successfully detecting the permission was granted.
    static func markScreenRecordingPermissionGranted() {
        UserDefaults.standard.set(true, forKey: screenRecordingPermissionKey)
    }

    /// Clear the cached screen recording permission state.
    /// Call this if you need to reset the permission state (e.g., during testing or if user revokes permission).
    static func clearScreenRecordingPermissionCache() {
        UserDefaults.standard.removeObject(forKey: screenRecordingPermissionKey)
    }

    // MARK: - Microphone Permission

    /// Check if microphone permission is granted.
    static var hasMicrophonePermission: Bool {
        return AVCaptureDevice.authorizationStatus(for: .audio) == .authorized
    }

    /// Request microphone permission.
    static func requestMicrophonePermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .audio, completionHandler: completion)
    }

    // MARK: - Combined Checks

    /// Check if all essential permissions (accessibility + screen recording) are granted.
    static var hasAllEssentialPermissions: Bool {
        return hasAccessibilityPermission && hasScreenRecordingPermission
    }
}
