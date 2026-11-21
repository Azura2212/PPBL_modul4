import 'package:flutter/material.dart';

class PetaPage extends StatelessWidget {
  const PetaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lokasi Kegiatan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Icon(
            Icons.location_on,
            size: 72,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Gedung Seminar Kampus',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Peta interaktif Google Maps tidak diaktifkan. '
            'Lokasi kegiatan berada di sekitar:',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading: Icon(Icons.place_outlined),
              title: Text('Koordinat'),
              subtitle: Text('-6.914744, 107.609810'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Informasi kegiatan'),
              subtitle: Text(
                'Seminar Teknologi Mobile • pukul 09.00 hingga selesai',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
