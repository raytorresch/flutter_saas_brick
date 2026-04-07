import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{projectName}}/core/l10n/gen_l10n/gen_l10n.dart';
import 'package:{{projectName}}/features/auth/presentation/screens/login_screen.dart';
import 'package:{{projectName}}/features/home/presentation/screens/home_screen.dart';

void main() {
  group('Smoke tests —', () {
    testWidgets('LoginScreen renders without crashing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );
      await tester.pump();

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
    });

    testWidgets('HomeScreen renders in initial state without crashing',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomeScreen(),
        ),
      );
      await tester.pump();

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('HomeScreen transitions to LoadInProgress on FAB tap',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomeScreen(),
        ),
      );
      await tester.pump();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(); // trigger state change

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
