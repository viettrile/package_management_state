import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Count: 0'), findsOneWidget);
    expect(find.text('Count: 1'), findsNothing);

    await tester.tap(find.text('+'));
    await tester.pump();

    expect(find.text('Count: 0'), findsNothing);
    expect(find.text('Count: 1'), findsOneWidget);
  });
}
