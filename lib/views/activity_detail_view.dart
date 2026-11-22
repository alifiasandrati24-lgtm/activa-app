
import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityViewModel viewModel;
  final ActivityModel activity;

  const ActivityDetailView({
    super.key,
    required this.viewModel,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    const pink = Color(0xFFFF3D9A);

    return Scaffold(
      backgroundColor: const Color(0xFF100D12),
      appBar: AppBar(
        title: const Text('Detail Aktivitas'),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF100D12),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: pink),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityFormView(
                    viewModel: viewModel,
                    activity: activity,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: pink),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF211B24),
                  title: const Text(
                    'Hapus Aktivitas?',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    'Apakah kamu yakin ingin menghapus aktivitas ini?',
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Hapus',
                        style: TextStyle(color: pink),
                      ),
                    ),
                  ],
                ),
              );

              if (confirm == true && context.mounted) {
                viewModel.deleteActivity(activity.id);
                Navigator.pop(context, 'deleted');
              }
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFF211B24),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: pink.withValues(alpha: 0.35),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.track_changes,
                      color: pink,
                      size: 75,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      activity.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'JUMLAH AKTIVITAS',
                      style: TextStyle(
                        color: Colors.white60,
                        letterSpacing: 2,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${activity.counter}',
                      style: const TextStyle(
                        fontSize: 58,
                        fontWeight: FontWeight.bold,
                        color: pink,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFF493044),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            viewModel.decrementCounter(activity.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Jumlah aktivitas diperbarui.'),
                                duration: Duration(milliseconds: 700),
                              ),
                            );
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 28),
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: pink,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            viewModel.incrementCounter(activity.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Jumlah aktivitas diperbarui.'),
                                duration: Duration(milliseconds: 700),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: pink,
                        side: const BorderSide(color: pink),
                      ),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: const Color(0xFF211B24),
                            title: const Text(
                              'Reset Penghitung?',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: const Text(
                              'Jumlah aktivitas akan kembali menjadi 0.',
                              style: TextStyle(color: Colors.white70),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, true),
                                child: const Text(
                                  'Reset',
                                  style: TextStyle(color: pink),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true && context.mounted) {
                          viewModel.resetCounter(activity.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Penghitung berhasil direset.'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset Penghitung'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
