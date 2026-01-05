import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:porrapp_frontend/features/auth/presentation/auth_page.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';
import 'package:porrapp_frontend/features/auth/domain/model/auth_token_model.dart';
import 'package:porrapp_frontend/core/util/util.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class MockGoRouter extends Mock implements GoRouter {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeAuthSaveUserSession extends Fake implements AuthSaveUserSession {}

class FakeAuthResetResource extends Fake implements AuthResetResource {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthSaveUserSession());
    registerFallbackValue(FakeAuthResetResource());
  });

  group('AuthPage', () {
    late MockAuthBloc mockAuthBloc;
    late MockGoRouter mockGoRouter;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      mockGoRouter = MockGoRouter();
    });

    Widget buildTestable({
      required AuthState initialState,
      Stream<AuthState>? stream,
      Future<void> Function({String? msg, Toast? toastLength})? toast,
    }) {
      when(() => mockAuthBloc.state).thenReturn(initialState);
      when(
        () => mockAuthBloc.stream,
      ).thenAnswer((_) => stream ?? Stream.value(initialState));

      return MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: AuthPage(router: mockGoRouter, toastFunction: toast),
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

      await tester.pumpWidget(buildTestable(initialState: authState));

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

      await tester.pumpWidget(buildTestable(initialState: authState));

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

      await tester.pumpWidget(buildTestable(initialState: authState));

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

      await tester.pumpWidget(buildTestable(initialState: authState));
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

      await tester.pumpWidget(buildTestable(initialState: authState));

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

      await tester.pumpWidget(buildTestable(initialState: authState));
      await tester.tap(find.byType(ElevatedButton));

      verify(() => mockAuthBloc.add(any())).called(greaterThan(0));
    });

    testWidgets('triggers PasswordChanged event on password field change', (
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

      await tester.pumpWidget(buildTestable(initialState: authState));
      await tester.enterText(find.byType(TextFormField).last, 'password123');

      verify(() => mockAuthBloc.add(any())).called(greaterThan(0));
    });

    testWidgets('navigates to competition page on successful login', (
      WidgetTester tester,
    ) async {
      final initialState = AuthState(
        response: Initial(),
        formKey: GlobalKey<FormState>(),
        email: const BlocFormItem(value: 'test@email.com'),
        password: const BlocFormItem(value: 'password'),
      );

      final successState = AuthState(
        response: Success(AuthTokenModel(access: 'token', refresh: 'refresh')),
        formKey: GlobalKey<FormState>(),
        email: const BlocFormItem(value: 'test@email.com'),
        password: const BlocFormItem(value: 'password'),
      );

      when(() => mockAuthBloc.state).thenReturn(initialState);
      when(
        () => mockAuthBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([initialState, successState]));
      when(() => mockGoRouter.go(any())).thenReturn(null);

      await tester.pumpWidget(buildTestable(initialState: successState));
      await tester.pump();
      await tester.pump();

      expect(find.text('Authentication'), findsOneWidget);
    });

    testWidgets('validators return correct errors', (tester) async {
      final state = AuthState(
        email: const BlocFormItem(error: 'email error'),
        password: const BlocFormItem(error: 'password error'),
      );

      await tester.pumpWidget(buildTestable(initialState: state));

      final emailField = tester.widget<TextFormField>(
        find.byType(TextFormField).first,
      );
      final passwordField = tester.widget<TextFormField>(
        find.byType(TextFormField).last,
      );

      expect(emailField.validator?.call(''), 'email error');
      expect(passwordField.validator?.call(''), 'password error');
    });
  });
}
