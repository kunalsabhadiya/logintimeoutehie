import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logintimeoutehie/screen/home.dart';
import 'package:logintimeoutehie/screen/login.dart';
import 'package:logintimeoutehie/screen/splash.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

import 'splash_test.mocks.dart';

@GenerateMocks([SharedPreferences, LocalAuthentication])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late MockLocalAuthentication mockLocalAuthentication;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockLocalAuthentication = MockLocalAuthentication();
  });

  Future<void> buildSplashScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Splash(),
      ),
    );
    await tester.pump(const Duration(seconds: 2));
  }

  group('Splash Screen Tests', () {


    testWidgets('displays Splash screen properly', (WidgetTester tester) async {
      await buildSplashScreen(tester);

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('navigates to HomeScreen if user is logged in, keepMeLoggedIn is true, and AuthActivation is false',
            (WidgetTester tester) async {

          when(mockSharedPreferences.getBool('isLoggedIn')).thenReturn(true);
          when(mockSharedPreferences.getBool('keepMeLoggedIn')).thenReturn(true);
          when(mockSharedPreferences.getBool('AuthActivation')).thenReturn(false);

          await buildSplashScreen(tester);
          await tester.pump(Duration(seconds: 3));
          expect(find.byType(HomeScreen), findsNWidgets(0));
        });

    testWidgets('navigates to AuthSetUpScreen if user is logged in, keepMeLoggedIn is true, and AuthActivation is true with available biometrics', (WidgetTester tester) async {
      when(mockSharedPreferences.getBool('isLoggedIn')).thenReturn(true);
      when(mockSharedPreferences.getBool('keepMeLoggedIn')).thenReturn(true);
      when(mockSharedPreferences.getBool('AuthActivation')).thenReturn(true);
      when(mockLocalAuthentication.canCheckBiometrics).thenAnswer((_) async => true);
      when(mockLocalAuthentication.authenticate(
        localizedReason: anyNamed('localizedReason'),
        options: anyNamed('options'),
      )).thenAnswer((_) async => true);

      await buildSplashScreen(tester);

      await tester.pump(Duration(seconds: 3)); // Wait for the timer to finish

      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('navigates to Login screen if user is not logged in or keepMeLoggedIn is false',
            (WidgetTester tester) async {
          when(mockSharedPreferences.getBool('isLoggedIn')).thenReturn(false);
          when(mockSharedPreferences.getBool('keepMeLoggedIn')).thenReturn(false);

          await buildSplashScreen(tester);
          await tester.pump(Duration(seconds: 3));

          expect(find.byType(Login), findsNWidgets(0));
        });

    testWidgets('navigates to HomeScreen if biometric authentication is successful',
            (WidgetTester tester) async {
          when(mockSharedPreferences.getBool('isLoggedIn')).thenReturn(true);
          when(mockSharedPreferences.getBool('keepMeLoggedIn')).thenReturn(true);
          when(mockSharedPreferences.getBool('AuthActivation')).thenReturn(true);
          when(mockLocalAuthentication.canCheckBiometrics).thenAnswer((_) async => true);
          when(mockLocalAuthentication.authenticate(
            localizedReason: anyNamed('localizedReason'),
            options: anyNamed('options'),
          )).thenAnswer((_) async => true);

          await buildSplashScreen(tester);
          await tester.pumpAndSettle();

          expect(find.byType(HomeScreen), findsNothing);
        });

    testWidgets('stays on Splash screen if biometric authentication fails',
            (WidgetTester tester) async {
          when(mockSharedPreferences.getBool('isLoggedIn')).thenReturn(true);
          when(mockSharedPreferences.getBool('keepMeLoggedIn')).thenReturn(true);
          when(mockSharedPreferences.getBool('AuthActivation')).thenReturn(true);
          when(mockLocalAuthentication.canCheckBiometrics).thenAnswer((_) async => true);
          when(mockLocalAuthentication.authenticate(
            localizedReason: anyNamed('localizedReason'),
            options: anyNamed('options'),
          )).thenAnswer((_) async => false);

          await buildSplashScreen(tester);
          await tester.pumpAndSettle();

          expect(find.byType(HomeScreen), findsNothing);
          expect(find.byType(Login), findsNothing);
        });
  });
}
