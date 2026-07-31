
# command for generating SHA-1 and SHA-256 fingerprints for Android debug keystore
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

