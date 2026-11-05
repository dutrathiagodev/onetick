import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/core/widgets/app_icon.dart';
import 'package:onetick/core/widgets/app_top_bar.dart';

import '../helpers/test_setup.dart';

void main() {
  testWidgets('shows the profile picture when there is one', (tester) async {
    await tester.pumpWidget(
      testApp(
        UserAvatarButton(
          onPressed: () {},
          photoUrl: 'https://lh3.googleusercontent.com/a/photo',
        ),
      ),
    );
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('falls back to the user icon without a picture', (tester) async {
    await tester.pumpWidget(testApp(UserAvatarButton(onPressed: () {})));
    expect(find.byType(Image), findsNothing);
    expect(find.byType(AppIcon), findsOneWidget);
  });
}
