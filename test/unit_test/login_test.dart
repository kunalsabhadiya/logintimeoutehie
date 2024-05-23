import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logintimeoutehie/screen/AuthSetUpScreen.dart';
import 'package:logintimeoutehie/screen/home.dart';
import 'package:logintimeoutehie/screen/login.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });

  Future<void> buildLoginScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Login(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('displays Login screen properly', (WidgetTester tester) async {
    await buildLoginScreen(tester);

    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('displays first time login screen properly', (WidgetTester tester) async {
    when(mockSharedPreferences.containsKey('InstanceID')).thenReturn(false);
    when(mockSharedPreferences.getBool('keepMeLoggedIn')).thenReturn(false);

    await buildLoginScreen(tester);

    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('logs in with keepMeLoggedIn checked', (WidgetTester tester) async {
    when(mockSharedPreferences.containsKey('InstanceID')).thenReturn(true);
    when(mockSharedPreferences.getBool('keepMeLoggedIn')).thenReturn(true);
    when(mockSharedPreferences.getBool('AuthActivation')).thenReturn(false);

    await buildLoginScreen(tester);

    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    verifyNever(mockSharedPreferences.setString('email', 'test@example.com'));
    verifyNever(mockSharedPreferences.setString('password', 'password'));
    verifyNever(mockSharedPreferences.setBool('isLoggedIn', true));
    verifyNever(mockSharedPreferences.setBool('keepMeLoggedIn', true));

    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('logs in with keepMeLoggedIn unchecked', (WidgetTester tester) async {
    when(mockSharedPreferences.containsKey('InstanceID')).thenReturn(true);
    when(mockSharedPreferences.getBool('keepMeLoggedIn')).thenReturn(false);
    when(mockSharedPreferences.getBool('AuthActivation')).thenReturn(false);

    await buildLoginScreen(tester);

    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    verifyNever(mockSharedPreferences.setString('email', 'test@example.com'));
    verifyNever(mockSharedPreferences.setString('password', 'password'));
    verifyNever(mockSharedPreferences.setBool('isLoggedIn', true));
    verifyNever(mockSharedPreferences.setBool('keepMeLoggedIn', false));

    expect(find.byType(HomeScreen), findsNothing);
  });



  testWidgets('shows HomeScreen if AuthActivation is true', (WidgetTester tester) async {
    when(mockSharedPreferences.containsKey('AuthActivation')).thenReturn(true);

    await buildLoginScreen(tester);

    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('shows AuthSetUpScreen if AuthActivation is false', (WidgetTester tester) async {
    when(mockSharedPreferences.containsKey('AuthActivation')).thenReturn(false);

    await buildLoginScreen(tester);

    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(AuthSetUpScreen), findsOneWidget);
  });


}
