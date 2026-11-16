import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/destination.dart';
import '../models/saved_store.dart';

class DestinationDetailScreen extends StatelessWidget {
  final Destination destination;
  const DestinationDetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/explore'),
        ),
        actions: [
          AnimatedBuilder(
            animation: savedStore,
            builder: (context, _) {
              final isSaved = savedStore.isSaved(destination.id);
              return IconButton(
                tooltip: isSaved ? 'ยกเลิกบันทึก' : 'บันทึกสถานที่',
                icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border,
                  color: isSaved ? Colors.red : null),
                onPressed: () {
                  savedStore.toggle(destination.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(isSaved ? 'ยกเลิกบันทึก ${destination.name}' : 'บันทึก ${destination.name} แล้ว!'),
                    duration: const Duration(seconds: 1),
                  ));
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 950),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            SizedBox(height: 290, width: double.infinity,
              child: Image.network(destination.imageUrl, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => ColoredBox(
                  color: Colors.blueGrey.shade100,
                  child: const Icon(Icons.image_not_supported, size: 65)))),
            Positioned(bottom: 0, left: 0, right: 0,
              child: Container(height: 115,
                decoration: const BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.bottomCenter, end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent])))),
            Positioned(bottom: 18, left: 20, right: 20,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(destination.name, style: const TextStyle(fontSize: 28,
                  fontWeight: FontWeight.bold, color: Colors.white)),
                Text(destination.country, style: const TextStyle(color: Colors.white70)),
              ])),
          ]),
          Padding(padding: const EdgeInsets.all(20), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(spacing: 12, runSpacing: 10, children: [
                Chip(avatar: const Icon(Icons.star, color: Colors.amber, size: 18),
                  label: Text('${destination.rating} Rating')),
                Chip(avatar: const Icon(Icons.attach_money, color: Colors.green, size: 18),
                  label: Text('\$${destination.price}/คืน')),
              ]),
              const SizedBox(height: 20),
              const Text('เกี่ยวกับ', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(destination.description, style: const TextStyle(fontSize: 15, height: 1.6)),
              const SizedBox(height: 20),
              const Text('สิ่งที่น่าสนใจ', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(spacing: 8, runSpacing: 5,
                children: destination.tags.map((tag) => Chip(label: Text(tag))).toList()),
              const SizedBox(height: 28),
              SizedBox(width: double.infinity, height: 52,
                child: FilledButton.icon(
                  icon: const Icon(Icons.flight_takeoff),
                  label: const Text('จองเลย'),
                  onPressed: () => showDialog<void>(context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('จองสำเร็จ! 🎉'),
                      content: Text('คุณได้จอง ${destination.name} เรียบร้อยแล้ว'),
                      actions: [TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          context.go('/');
                        },
                        child: const Text('กลับหน้าหลัก'),
                      )],
                    )),
                )),
            ],
          )),
        ]),
      ))),
    );
  }
}
