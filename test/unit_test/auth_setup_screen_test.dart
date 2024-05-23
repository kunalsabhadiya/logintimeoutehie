import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logintimeoutehie/screen/AuthSetUpScreen.dart';
import 'package:logintimeoutehie/screen/home.dart';
import 'package:mockito/mockito.dart';

import 'splash_test.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late MockLocalAuthentication mockLocalAuthentication;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockLocalAuthentication = MockLocalAuthentication();
  });

  Future<void> buildAuthSetUpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthSetUpScreen(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('displays AuthSetUpScreen properly', (WidgetTester tester) async {
    await buildAuthSetUpScreen(tester);

    expect(find.text('Two Factor Authentication'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.textContaining('If you want to secure your data'), findsOneWidget);
    expect(find.text('Biometric Authentication'), findsOneWidget);
    expect(find.text('Remind me, later.'), findsOneWidget);
  });

  testWidgets('navigates to HomeScreen on "Remind me, later." button press',
      (WidgetTester tester) async {
    await buildAuthSetUpScreen(tester);

    when(mockSharedPreferences.setBool('AuthActivation', false))
        .thenAnswer((_) async => true);

    await tester.tap(find.text('Remind me, later.'));
    await tester.pumpAndSettle();

    verifyNever(mockSharedPreferences.setBool('AuthActivation', false));
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('checks biometric authentication flow',
      (WidgetTester tester) async {
    await buildAuthSetUpScreen(tester);

    when(mockLocalAuthentication.canCheckBiometrics)
        .thenAnswer((_) async => true);
    when(mockLocalAuthentication.authenticate(
      localizedReason: anyNamed('localizedReason'),
      options: anyNamed('options'),
    )).thenAnswer((_) async => true);

    await tester.tap(find.text('Biometric Authentication'));
    await tester.pumpAndSettle();

    verifyNever(mockLocalAuthentication.canCheckBiometrics);
    verifyNever(mockLocalAuthentication.authenticate(
      localizedReason: anyNamed('localizedReason'),
      options: anyNamed('options'),
    ));
    verifyNever(mockSharedPreferences.setBool('AuthActivation', true));
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('prints data on initState', (WidgetTester tester) async {
    await buildAuthSetUpScreen(tester);

    verifyNever(mockSharedPreferences.getString('email'));
    verifyNever(mockSharedPreferences.getString('password'));
    verifyNever(mockSharedPreferences.getBool('isLoggedIn'));
    verifyNever(mockSharedPreferences.containsKey('InstanceID'));
    verifyNever(mockSharedPreferences.getString('InstanceID'));
    verifyNever(mockSharedPreferences.getBool('keepMeLoggedIn'));
  });
}
