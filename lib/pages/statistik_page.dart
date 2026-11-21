import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pendaftar_model.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PendaftarModel>();
    final jumlah = [
      model.jumlahSesi('Pagi'),
      model.jumlahSesi('Siang'),
      model.jumlahSesi('Sore'),
    ];
    final total = jumlah.fold<int>(0, (hasil, nilai) => hasil + nilai);
    final warna = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Pendaftar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Total pendaftar: $total',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (total == 0)
            const Text('Belum ada pendaftar.')
          else
            Text(
              'Pagi: ${jumlah[0]}  •  Siang: ${jumlah[1]}  •  Sore: ${jumlah[2]}',
            ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                maxY: math.max(1, jumlah.reduce(math.max) + 1).toDouble(),
                barGroups: [
                  for (var indeks = 0; indeks < jumlah.length; indeks++)
                    BarChartGroupData(
                      x: indeks,
                      barRods: [
                        BarChartRodData(
                          toY: jumlah[indeks].toDouble(),
                          color: warna,
                          width: 36,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    ),
                ],
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (nilai, meta) {
                        const sesi = ['Pagi', 'Siang', 'Sore'];
                        final indeks = nilai.toInt();
                        if (indeks < 0 || indeks >= sesi.length) {
                          return const SizedBox.shrink();
                        }
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(sesi[indeks]),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
