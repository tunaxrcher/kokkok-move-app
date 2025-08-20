# 🔑 KOKKOK Move - API Keys Setup Guide

## 📋 Required API Keys

### 1. Google Maps API Key
- **Purpose**: แสดงแมพและ location services
- **Platforms**: Web, Android, iOS
- **Get from**: [Google Cloud Console](https://console.cloud.google.com/)

### 2. Google Sign-In Client ID  
- **Purpose**: Authentication ด้วย Google account
- **Platforms**: Web, Android, iOS
- **Get from**: [Google Cloud Console](https://console.cloud.google.com/)

## 🛠️ Setup Instructions

### 🌐 **Web Platform**

**File**: `web/index.html`

```html
<!-- Google Maps API -->
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_WEB_API_KEY&libraries=places"></script>

<!-- Google Sign-In -->
<meta name="google-signin-client_id" content="YOUR_WEB_CLIENT_ID" />
```

### 🤖 **Android Platform**

**File**: `android/app/src/main/AndroidManifest.xml`

```xml
<!-- Inside <application> tag -->
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="YOUR_ANDROID_API_KEY"/>
```

### 🍎 **iOS Platform**

**File**: `ios/Runner/AppDelegate.swift`

```swift
import GoogleMaps

override func application(...) -> Bool {
    GMSServices.provideAPIKey("YOUR_IOS_API_KEY")
    // ... rest of code
}
```

## 🔧 **Step-by-Step Setup**

### 1. **Get Google Maps API Key**
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create new project or select existing
3. Enable "Maps JavaScript API" (for Web)
4. Enable "Maps SDK for Android" (for Android)
5. Enable "Maps SDK for iOS" (for iOS)
6. Create API Key in "Credentials"
7. Restrict API key by platform and APIs

### 2. **Get Google Sign-In Client ID**
1. In Google Cloud Console
2. Go to "Credentials" 
3. Create "OAuth 2.0 Client IDs"
4. Configure for each platform:
   - **Web**: Add your domain
   - **Android**: Add package name and SHA-1
   - **iOS**: Add bundle identifier

### 3. **Configure Each Platform**

#### **Web:**
```html
<!-- In web/index.html -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBxxxxx&libraries=places"></script>
<meta name="google-signin-client_id" content="123456789-xxxxx.apps.googleusercontent.com" />
```

#### **Android:**
```xml
<!-- In android/app/src/main/AndroidManifest.xml -->
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="AIzaSyBxxxxx"/>
```

#### **iOS:**
```swift
// In ios/Runner/AppDelegate.swift
GMSServices.provideAPIKey("AIzaSyBxxxxx")
```

## ⚡ **Quick Start (Same Key for All)**

If you configure your API key properly in Google Cloud Console, you can use the **same key** for all platforms:

1. **Replace all instances** of placeholder keys with your actual key
2. **Make sure** your key has permissions for:
   - Maps JavaScript API
   - Maps SDK for Android  
   - Maps SDK for iOS
   - Places API
   - Geocoding API

## 🚨 **Security Notes**

- **Never commit** real API keys to public repositories
- **Use environment variables** in production
- **Restrict API keys** by platform and referrer
- **Monitor usage** in Google Cloud Console

## 🎯 **After Setup**

Once you've added the API keys:
1. **Restart the app** completely
2. **Google Maps** will display real maps
3. **Location services** will work
4. **Google Sign-In** will work on web
5. **Geocoding** will provide real addresses

---

**Current Status**: Ready for API key integration
**Next Step**: Add your Google Maps API key and Google Sign-In Client ID
