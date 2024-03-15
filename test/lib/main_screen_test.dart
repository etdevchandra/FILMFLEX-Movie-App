import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:filmflex_movie_application/main_screen.dart';
import 'main_screen_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    // Setting up mock initial values and behaviors
    SharedPreferences.setMockInitialValues({});
    when(mockPrefs.getString(any)).thenReturn(null);
    when(mockPrefs.remove('email')).thenAnswer((_) async => true);
    // Here, you'd inject mockPrefs into your application or service locator.
  });

  Future<void> pumpMainScreen(WidgetTester tester) async {
    // Example of pumping the MainScreen with a mock SharedPreferences instance
    await tester.pumpWidget(MaterialApp(home: MainScreen()));
    // Add your method of injecting mockPrefs into MainScreen if possible
  }

  group('MainScreen Tests', () {
    testWidgets('Initializes with 4 tabs and displays them correctly', (WidgetTester tester) async {
      await pumpMainScreen(tester);
      expect(find.byType(TabBarView), findsOneWidget);
      final TabBarView tabBarView = tester.widget(find.byType(TabBarView));
      expect(tabBarView.children.length, 4); // Verifying 4 tabs are present
    });

    testWidgets('Displays search choice dialog on search icon tap', (WidgetTester tester) async {
      await pumpMainScreen(tester);
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle(); // Wait for the dialog to appear

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('What are you searching for?'), findsOneWidget);
    });
  });
}
