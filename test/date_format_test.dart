import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DateTime parse test', () {
    print(DateTime.parse("2026-02-25T10:00:00Z"));
    try {
      print(DateTime.parse("2026-02-25T10:00Z"));
    } catch (e) {
      print("Failed parsing without seconds: $e");
    }
  });
}
