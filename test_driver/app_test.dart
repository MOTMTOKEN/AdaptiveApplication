import 'package:flutter_driver/flutter_driver.dart';
import 'package:shops_app/constants.dart';
import 'package:test/test.dart';

void main(){
  group('Test Login Screen', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
        driver?.close();

    });


    test('Test initial Setup', () async {

      expect(await driver.getText(find.byValueKey(Constants.CREATE_ACCOUNT_KEY)), Constants.CREATE_ACCOUNT_TEXT);
      expect(await isPresent(find.byValueKey(Constants.KEY_EMAIL), driver), isTrue);
      expect(await isPresent(find.byValueKey(Constants.KEY_PASSWORD), driver), isTrue);
      expect(await isPresent(find.byValueKey(Constants.KEY_CONFIRM_PASSWORD), driver), isFalse);
      expect(await isPresent(find.byValueKey(Constants.KEY_SIGNUP_BUTTON), driver), isFalse);
      expect(await isPresent(find.byValueKey(Constants.KEY_LOGIN_BUTTON), driver), isTrue);

      await driver.tap(find.byValueKey(Constants.CREATE_ACCOUNT_KEY));

      //Sign up view
      expect(await driver.getText(find.byValueKey(Constants.CREATE_ACCOUNT_KEY)), Constants.ALREADT_HAVE_AN_ACCOUNT_TEXT);
      expect(await isPresent(find.byValueKey(Constants.KEY_EMAIL), driver), isTrue);
      expect(await isPresent(find.byValueKey(Constants.KEY_PASSWORD), driver), isTrue);
      expect(await isPresent(find.byValueKey(Constants.KEY_CONFIRM_PASSWORD), driver), isTrue);
      expect(await isPresent(find.byValueKey(Constants.KEY_LOGIN_BUTTON), driver), isFalse);

      await driver.tap(find.byValueKey(Constants.KEY_EMAIL));
      await driver.enterText('abc');

      await driver.tap(find.byValueKey(Constants.KEY_PASSWORD));
      await driver.enterText('abc');


      await driver.tap(find.byValueKey(Constants.KEY_CONFIRM_PASSWORD));
      await driver.enterText('abcd12');

      await driver.tap(find.text(Constants.SIGN_UP_BUTTON_TEXT));
      expect(await driver.getText(find.text(Constants.ERROR_EMAIL)), Constants.ERROR_EMAIL);
      expect(await driver.getText(find.text(Constants.ERROR_PASSWORD)), Constants.ERROR_PASSWORD);
      expect(await driver.getText(find.text(Constants.ERROR_PASSWORD_MATCHING)), Constants.ERROR_PASSWORD_MATCHING);


      await driver.tap(find.byValueKey(Constants.KEY_EMAIL));
      await driver.enterText('abc@def.com');

      await driver.tap(find.byValueKey(Constants.KEY_PASSWORD));
      await driver.enterText('abcd12');


      await driver.tap(find.byValueKey(Constants.KEY_CONFIRM_PASSWORD));
      await driver.enterText('abcd12');

      await driver.tap(find.text(Constants.SIGN_UP_BUTTON_TEXT));

      expect(await isPresent(find.text(Constants.ERROR_EMAIL), driver), isFalse);
      expect(await isPresent(find.text(Constants.ERROR_PASSWORD), driver), isFalse);
      expect(await isPresent(find.text(Constants.ERROR_PASSWORD_MATCHING), driver), isFalse);
    });

  });
}

isPresent(SerializableFinder byValueKey, FlutterDriver driver, {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(byValueKey,timeout: timeout);
    return true;
  } catch(exception) {
    return false;
  }
}