@echo off
echo Getting SHA-1 Certificate Fingerprint...
echo.

REM Using keytool from Android Studio
"C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

echo.
echo Copy the SHA1 fingerprint from above and use it in Google Cloud Console
echo for Google Sign-In configuration.
pause
