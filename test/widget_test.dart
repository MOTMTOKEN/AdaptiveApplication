// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shops_app/constants.dart';
import 'package:shops_app/screens/my_home_page.dart';

Widget _makeWidgetTestable(Widget widget) => MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget,),);


void main() {
  testWidgets('Change My Home Page Widget', (WidgetTester tester) async {
    await tester.pumpWidget(_makeWidgetTestable(MyHomePage()));
    // DEFAULT VIEW
    expect(find.text(Constants.CREATE_ACCOUNT_TEXT), findsOneWidget);
    expect(find.text(Constants.LOGIN_BUTTON_TEXT), findsOneWidget);
    expect(find.text(Constants.SIGN_UP_BUTTON_TEXT), findsNothing);
    expect(find.text(Constants.ALREADT_HAVE_AN_ACCOUNT_TEXT), findsNothing);
    expect(find.byKey(ValueKey(Constants.KEY_CONFIRM_PASSWORD)), findsNothing);

    //Press create button
    await tester.tap(find.text(Constants.CREATE_ACCOUNT_TEXT));
    await tester.pump();

    //Sign up View

    expect(find.text(Constants.CREATE_ACCOUNT_TEXT), findsNothing);
    expect(find.text(Constants.LOGIN_BUTTON_TEXT), findsNothing);
    expect(find.text(Constants.SIGN_UP_BUTTON_TEXT), findsOneWidget);
    expect(find.text(Constants.ALREADT_HAVE_AN_ACCOUNT_TEXT), findsOneWidget);
    expect(find.byKey(ValueKey(Constants.KEY_CONFIRM_PASSWORD)), findsOneWidget);

    await tester.enterText(find.byKey(ValueKey(Constants.KEY_EMAIL)), 'test');
    await tester.enterText(find.byKey(ValueKey(Constants.KEY_PASSWORD)), 'ab');
    await tester.enterText(find.byKey(ValueKey(Constants.KEY_CONFIRM_PASSWORD)), 'test1');

    
    await tester.tap(find.text(Constants.SIGN_UP_BUTTON_TEXT));
    await tester.pump();

    expect(find.text(Constants.ERROR_EMAIL), findsOneWidget);
    expect(find.text(Constants.ERROR_PASSWORD), findsOneWidget);
    expect(find.text(Constants.ERROR_PASSWORD_MATCHING), findsOneWidget);


    await tester.enterText(find.byKey(ValueKey(Constants.KEY_EMAIL)), 'test@test.com');
    await tester.enterText(find.byKey(ValueKey(Constants.KEY_PASSWORD)), 'test1');
    await tester.enterText(find.byKey(ValueKey(Constants.KEY_CONFIRM_PASSWORD)), 'test1');

    await tester.tap(find.text(Constants.SIGN_UP_BUTTON_TEXT));
    await tester.pump();

    expect(find.text(Constants.ERROR_EMAIL), findsNothing);
    expect(find.text(Constants.ERROR_PASSWORD), findsNothing);
    expect(find.text(Constants.ERROR_PASSWORD_MATCHING), findsNothing);

  });
}
