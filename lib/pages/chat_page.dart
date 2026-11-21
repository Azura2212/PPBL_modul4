import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final pesanController = TextEditingController();
  final List<_PesanChat> pesan = [
    const _PesanChat(
      teks: 'Selamat datang, ada yang bisa dibantu?',
      dariSaya: false,
    ),
  ];

  void kirimPesan() {
    final teks = pesanController.text.trim();
    if (teks.isEmpty) return;

    setState(() {
      pesan.add(_PesanChat(teks: teks, dariSaya: true));
      pesanController.clear();
    });
  }

  @override
  void dispose() {
    pesanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final warnaSaya = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Tanya Petugas')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8),
              itemCount: pesan.length,
              itemBuilder: (context, index) {
                final data = pesan[pesan.length - 1 - index];
                return Align(
                  alignment: data.dariSaya
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: data.dariSaya
                          ? warnaSaya
                          : Theme.of(context).colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      data.teks,
                      style: TextStyle(
                        color: data.dariSaya
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pesanController,
                    decoration: const InputDecoration(
                      hintText: 'Tulis pesan...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => kirimPesan(),
                  ),
                ),
                IconButton(
                  tooltip: 'Kirim pesan',
                  icon: const Icon(Icons.send),
                  onPressed: kirimPesan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PesanChat {
  const _PesanChat({required this.teks, required this.dariSaya});

  final String teks;
  final bool dariSaya;
}
