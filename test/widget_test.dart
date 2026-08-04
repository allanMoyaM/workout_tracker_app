import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker_app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Mis Entrenamientos'), findsOneWidget);
  });
}
