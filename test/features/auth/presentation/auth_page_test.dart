import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:porrapp_frontend/features/auth/presentation/auth_page.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';
import 'package:porrapp_frontend/core/util/util.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class MockGoRouter extends Mock implements GoRouter {}

class FakeAuthEvent extends Fake implements AuthEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
  });
  group('AuthPage', () {
    late MockAuthBloc mockAuthBloc;
    late MockGoRouter mockGoRouter;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      mockGoRouter = MockGoRouter();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: AuthPage(router: mockGoRouter),
        ),
      );
    }

    testWidgets('displays AppBar with Authentication title', (
      WidgetTester tester,
    ) async {
      final authState = AuthState(
        response: Initial(),
        formKey: GlobalKey<FormState>(),
        email: const BlocFormItem(value: ''),
        password: const BlocFormItem(value: ''),
      );

      when(() => mockAuthBloc.state).thenReturn(authState);
      when(
        () => mockAuthBloc.stream,
      ).thenAnswer((_) => Stream.value(authState));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Authentication'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays email and password TextFormFields', (
      WidgetTester tester,
    ) async {
      final authState = AuthState(
        response: Initial(),
        formKey: GlobalKey<FormState>(),
        email: const BlocFormItem(value: ''),
        password: const BlocFormItem(value: ''),
      );

      when(() => mockAuthBloc.state).thenReturn(authState);
      when(
        () => mockAuthBloc.stream,
      ).thenAnswer((_) => Stream.value(authState));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsWidgets);
      expect(find.text('E-mail'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('displays CircularProgressIndicator when loading', (
      WidgetTester tester,
    ) async {
      final authState = AuthState(
        response: LoadingPage(),
        formKey: GlobalKey<FormState>(),
        email: const BlocFormItem(value: ''),
        password: const BlocFormItem(value: ''),
      );

      when(() => mockAuthBloc.state).thenReturn(authState);
      when(
        () => mockAuthBloc.stream,
      ).thenAnswer((_) => Stream.value(authState));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('triggers EmailChanged event on email field change', (
      WidgetTester tester,
    ) async {
      final authState = AuthState(
        response: Initial(),
        formKey: GlobalKey<FormState>(),
        email: const BlocFormItem(value: ''),
        password: const BlocFormItem(value: ''),
      );

      when(() => mockAuthBloc.state).thenReturn(authState);
      when(
        () => mockAuthBloc.stream,
      ).thenAnswer((_) => Stream.value(authState));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(
        find.byType(TextFormField).first,
        'test@email.com',
      );

      verify(() => mockAuthBloc.add(any())).called(greaterThan(0));
    });

    testWidgets('displays Login button', (WidgetTester tester) async {
      final authState = AuthState(
        response: Initial(),
        formKey: GlobalKey<FormState>(),
        email: const BlocFormItem(value: ''),
        password: const BlocFormItem(value: ''),
      );

      when(() => mockAuthBloc.state).thenReturn(authState);
      when(
        () => mockAuthBloc.stream,
      ).thenAnswer((_) => Stream.value(authState));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('triggers AuthSubmitted event on Login button press', (
      WidgetTester tester,
    ) async {
      final authState = AuthState(
        response: Initial(),
        formKey: GlobalKey<FormState>(),
        email: const BlocFormItem(value: ''),
        password: const BlocFormItem(value: ''),
      );

      when(() => mockAuthBloc.state).thenReturn(authState);
      when(
        () => mockAuthBloc.stream,
      ).thenAnswer((_) => Stream.value(authState));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byType(ElevatedButton));

      verify(() => mockAuthBloc.add(any())).called(greaterThan(0));
    });
  });
}
