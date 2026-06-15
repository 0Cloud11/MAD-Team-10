import 'package:flutter_test/flutter_test.dart';
import 'package:ai_learning_hub/main.dart';

void main() {
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(keepSignedIn: false));

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('Username/ Email'), findsOneWidget);
  });
}
