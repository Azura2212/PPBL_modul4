import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_pendaftaran_nim/main.dart';
import 'package:form_pendaftaran_nim/model/pendaftar_model.dart';
import 'package:form_pendaftaran_nim/pages/chat_page.dart';
import 'package:provider/provider.dart';

Widget createTestApp() {
  return ChangeNotifierProvider(
    create: (_) => PendaftarModel(),
    child: const MyApp(),
  );
}

void main() {
  testWidgets('form requires all fields and updates session statistics', (
    tester,
  ) async {
    await tester.pumpWidget(createTestApp());

    final submitButton = find.widgetWithText(
      ElevatedButton,
      'Kirim Pendaftaran',
    );
    expect(tester.widget<ElevatedButton>(submitButton).onPressed, isNull);

    await tester.enterText(find.byType(TextField).at(0), 'Dina Putri');
    await tester.enterText(find.byType(TextField).at(1), 'dina@example.com');
    await tester.tap(find.byType(CheckboxListTile));
    await tester.tap(find.text('Sesi Pagi'));
    await tester.pumpAndSettle();
    expect(tester.widget<ElevatedButton>(submitButton).onPressed, isNotNull);

    await tester.tap(submitButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Pendaftaran berhasil dikirim'), findsOneWidget);

    await tester.tap(find.text('Statistik'));
    await tester.pumpAndSettle();
    expect(find.text('Total pendaftar: 1'), findsOneWidget);
    expect(find.text('Pagi: 1  •  Siang: 0  •  Sore: 0'), findsOneWidget);
  });

  testWidgets('chat sends a non-empty message', (tester) async {
    await tester.pumpWidget(createTestApp());
    await tester.tap(find.text('Chat'));
    await tester.pumpAndSettle();

    final chatInput = find.descendant(
      of: find.byType(ChatPage),
      matching: find.byType(TextField),
    );
    await tester.enterText(chatInput, 'Mohon info jadwal');
    await tester.tap(find.byTooltip('Kirim pesan'));
    await tester.pumpAndSettle();

    expect(find.text('Mohon info jadwal'), findsOneWidget);
  });

  testWidgets('event card opens its detail route', (tester) async {
    await tester.pumpWidget(createTestApp());

    await tester.tap(find.text('Seminar Teknologi Mobile'));
    await tester.pumpAndSettle();

    expect(find.text('Detail Kegiatan'), findsOneWidget);
    expect(find.textContaining('pukul 09.00'), findsOneWidget);
  });
}
