import 'package:flutter/material.dart';
import 'package:minimals/constants/constants.dart';
import 'package:minimals/utils/snackbar_util.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final GetStorage _storage = GetStorage();
  int failedAttempts = 0;
  final int maxAttempts = 3;

  Future<bool> authenticateWithBiometrics() async {
    try {
      debugPrint('_localAuth.isDeviceSupported():>>${_localAuth.isDeviceSupported()}');
      bool isSupported = await _localAuth.isDeviceSupported();
      if (!isSupported) return false;

      List<BiometricType> biometricType = await _localAuth.getAvailableBiometrics();
      if (biometricType.isEmpty) return false;

      bool canAuthenticate = await _localAuth.canCheckBiometrics;
      if (!canAuthenticate) return false;

      debugPrint(biometricType.toString());
      if (failedAttempts >= maxAttempts) {
        showSnackBar("Too many failed attempts. Try again later.");
        return false;
      }
      bool authenticated = false;
      if (biometricType.contains(BiometricType.strong) || biometricType.contains(BiometricType.weak)) {
        try {
          final LocalAuthentication localAuth = LocalAuthentication();
          authenticated = await localAuth.authenticate(
            localizedReason: 'Authenticate to access the app',
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
            ),
          );
          debugPrint("Authenticated: $authenticated");
        } catch (e) {
          debugPrint("Error during authentication: $e");
        }

        if (authenticated) {
          failedAttempts = 0; // Reset the failed attempts counter
          return true;
        } else {
          failedAttempts++;
          showSnackBar('Authentication failed. Attempt $failedAttempts/$maxAttempts');
        }
      }

      // For iOS, Face ID is handled by default if available
      if (biometricType.contains(BiometricType.face)) {
        return await _localAuth.authenticate(
          localizedReason: 'Authenticate to access the app',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
      }
      return false;
    } catch (e) {
      // Handle any errors that occur during authentication
      return false;
    }
  }

  Future<bool> isBiometricSupported() async {
    return await _localAuth.isDeviceSupported();
  }

  void saveMPIN(String mpin) {
    _storage.write(StorageKeys.mPin, mpin);
  }

  String? getMPIN() {
    return _storage.read(StorageKeys.mPin);
  }

  bool validateMPIN(String mPin) {
    String? storedMPIN = getMPIN();
    return storedMPIN == mPin;
  }
}
