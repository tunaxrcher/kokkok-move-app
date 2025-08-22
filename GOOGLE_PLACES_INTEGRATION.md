# Google Places API Integration

## Overview
แอปพลิเคชัน KOKKOK Move ได้ถูกปรับปรุงให้ใช้ Google Places API เพื่อให้ฟีเจอร์ map และ search ทำงานกับข้อมูลจริง

## Features ที่เพิ่มเข้ามา

### 1. Place Autocomplete
- ใช้ Google Places Autocomplete API สำหรับการค้นหาสถานที่
- รองรับการค้นหาด้วยภาษาไทยและภาษาอังกฤษ
- จำกัดผลลัพธ์ให้อยู่ในประเทศไทย
- ใช้ session token เพื่อลดค่าใช้จ่าย API

### 2. Nearby Places
- แสดงสถานที่ใกล้เคียงสำหรับจุดปลายทาง
- ค้นหาสถานประกอบการในรัศมี 10 กิโลเมตร
- แสดงผลเฉพาะเมื่อเลือกจุดปลายทาง

### 3. Place Details
- ดึงข้อมูลรายละเอียดของสถานที่จาก Place ID
- รวมถึงชื่อ, ที่อยู่, และพิกัด

### 4. Current Location Integration
- แสดงตำแหน่งปัจจุบันเป็นตัวเลือกแรกสำหรับจุดรับ
- ใช้พิกัดปัจจุบันในการค้นหาสถานที่ใกล้เคียง

## Technical Implementation

### New Services
1. **GooglePlacesService** (`lib/shared/services/google_places_service.dart`)
   - จัดการการเรียก Google Places API
   - รองรับ Autocomplete, Place Details, Nearby Search, และ Text Search

2. **Enhanced LocationService** (`lib/shared/services/location_service.dart`)
   - เพิ่มเมธอดสำหรับ Places API
   - Fallback ไปใช้ geocoding หาก Places API ล้มเหลว

### Updated Components
1. **LocationSearchSheet** (`lib/features/home/presentation/widgets/location_search_sheet.dart`)
   - ใช้ Places Autocomplete แทนการค้นหาแบบเดิม
   - แสดงสถานที่ใกล้เคียงและตำแหน่งปัจจุบัน
   - Debounce search เพื่อลดการเรียก API

2. **HomeContent** (`lib/features/home/presentation/pages/home_content.dart`)
   - ส่ง current location ไปยัง LocationSearchSheet

## API Configuration

### Required API Keys
- Web: `Environment.googleMapsApiKeyWeb`
- Android: `Environment.googleMapsApiKeyAndroid`
- iOS: `Environment.googleMapsApiKeyIOS`

### API Permissions Required
Google Cloud Console ต้องเปิดใช้งาน APIs ต่อไปนี้:
- Places API
- Maps JavaScript API (สำหรับ Web)
- Maps SDK for Android
- Maps SDK for iOS

### API Restrictions
- จำกัดการค้นหาในประเทศไทย (`components: country:th`)
- ใช้ภาษาไทยเป็นหลัก (`language: th`)
- ใช้ session token เพื่อประหยัด API quota

## Usage Examples

### Search for Places
```dart
final predictions = await locationService.getPlacePredictions(
  'สยาม',
  currentLocation: currentLocation,
  sessionToken: sessionToken,
);
```

### Get Place Details
```dart
final location = await locationService.getPlaceDetails(placeId);
```

### Get Nearby Places
```dart
final nearbyPlaces = await locationService.getNearbyPlaces(
  currentLocation,
  radius: 5000,
  type: 'establishment',
);
```

## Dependencies Added
```yaml
dependencies:
  http: ^1.2.2
  uuid: ^4.5.1
  google_places_flutter: ^2.0.9
  google_polyline_algorithm: ^3.1.0
```

## Error Handling
- Graceful fallback ไปใช้ geocoding API หาก Places API ล้มเหลว
- แสดงสถานที่ยอดนิยมหากไม่มีผลลัพธ์การค้นหา
- Timeout และ retry mechanism สำหรับ network requests

## Performance Optimizations
- Debounce search input (500ms)
- Session token สำหรับ Autocomplete
- จำกัดจำนวนผลลัพธ์ที่แสดง
- Cache popular locations

## Testing
เพื่อทดสอบการทำงานของ Google Places API:
1. ตรวจสอบ API key ใน `lib/core/config/environment.dart`
2. เปิดแอป และทดลองค้นหาสถานที่
3. ตรวจสอบ console logs สำหรับ API responses
4. ทดสอบทั้งการค้นหาจุดรับและจุดปลายทาง

## Cost Optimization Tips
1. ใช้ session token สำหรับ Autocomplete
2. จำกัด radius สำหรับ Nearby Search
3. Cache ผลลัพธ์ที่ใช้บ่อย
4. ใช้ debounce เพื่อลดจำนวน API calls
5. Fallback ไปใช้ geocoding สำหรับ basic search

## Troubleshooting

### Common Issues
1. **API Key ไม่ทำงาน**
   - ตรวจสอบว่า API key ถูกต้อง
   - เปิดใช้งาน Places API ใน Google Cloud Console
   - ตรวจสอบ API restrictions

2. **ไม่มีผลลัพธ์การค้นหา**
   - ตรวจสอบ network connection
   - ดู console logs สำหรับ error messages
   - ลองค้นหาด้วยคำที่แตกต่างกัน

3. **App ช้า**
   - ตรวจสอบ debounce timing
   - ลด radius สำหรับ nearby search
   - เพิ่ม timeout สำหรับ API calls

## Future Enhancements
- เพิ่ม place photos
- รองรับ place ratings และ reviews
- เพิ่ม directions API สำหรับ route planning
- Cache management สำหรับ offline support
