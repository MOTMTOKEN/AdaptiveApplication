import 'package:flutter_test/flutter_test.dart';

import 'package:shops_app/utils/text_validators.dart';
void main() {

  group('Test multiple email values', () {
    test('Single name is not an email', () {
      expect('test'.isEmailValid(), false);
    });


    test('Single name with @ sign is not an email', () {
      expect('test@'.isEmailValid(), false);
    });


    test('Single name with @ and sign is not an email', () {
      expect('test@test'.isEmailValid(), false);
    });


    test('Single name with @ , domain address is  an email', () {
      expect('test@test.com'.isEmailValid(), true);
    });

    test('Single name with @ , domain address and country is  an email', () {
      expect('test@test.co.uk'.isEmailValid(), true);
    });
  });

}