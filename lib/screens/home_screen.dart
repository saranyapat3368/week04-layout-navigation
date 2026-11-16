import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/destination.dart';
import '../models/saved_store.dart';
import '../widgets/destination_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Checkpoint 4.3: แสดงครบ 6 รายการ ไม่ใช้ take(3)
    final featured = sampleDestinations;
    final topRated = [...sampleDestinations]
      ..sort((a, b) => b.rating.compareTo(a.rating));
    final top3 = topRated.take(3).toList();

    return Scaffold(body: SafeArea(child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('สวัสดี, นักเดินทาง! 👋', style: TextStyle(color: Colors.grey)),
              Text('ไปไหนดีวันนี้?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ]),
            CircleAvatar(backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.person, color: Colors.blue)),
          ]),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('แนะนำสำหรับคุณ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextButton(onPressed: () => context.go('/explore'), child: const Text('ดูทั้งหมด')),
          ]),
          const SizedBox(height: 8),
          SizedBox(height: 280, child: ListView.separated(
            key: const PageStorageKey<String>('home-featured'),
            scrollDirection: Axis.horizontal,
            itemCount: featured.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final d = featured[index];
              return SizedBox(width: 220, child: DestinationCard(
                destination: d,
                onTap: () => context.pushNamed('destination-detail',
                  pathParameters: {'id': d.id}, extra: d),
              ));
            },
          )),
          const SizedBox(height: 26),
          const Text('สถิติการเดินทาง', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          AnimatedBuilder(animation: savedStore, builder: (context, _) {
            return Row(children: [
              const Expanded(child: _StatCard(icon: Icons.flight_takeoff,
                label: 'Trip', value: '5', color: Colors.blue)),
              const SizedBox(width: 8),
              const Expanded(child: _StatCard(icon: Icons.place,
                label: 'Country', value: '3', color: Colors.orange)),
              const SizedBox(width: 8),
              Expanded(child: _StatCard(icon: Icons.favorite,
                label: 'Saved', value: '${savedStore.savedIds.length}', color: Colors.pink)),
            ]);
          }),
          const SizedBox(height: 26),
          const Text('รีวิวยอดนิยม', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Column(children: [
            // Checkpoint 4.3: shrinkWrap ให้ ListView ใช้ความสูงตามรายการ
            // NeverScrollableScrollPhysics ป้องกันการเลื่อนซ้อนกับ SingleChildScrollView
            // ถ้าไม่กำหนดข้อจำกัด อาจเกิด unbounded height หรือการเลื่อนแย่งกัน
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: top3.length,
              itemBuilder: (context, index) {
                final d = top3[index];
                return Card(child: ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(d.name),
                  subtitle: Text(d.country),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    Text('${d.rating}'),
                  ]),
                  onTap: () => context.pushNamed('destination-detail',
                    pathParameters: {'id': d.id}, extra: d),
                ));
              },
            ),
          ]),
        ]),
      ),
    )));
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatCard({required this.icon, required this.label,
    required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
      decoration: BoxDecoration(color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(icon, color: color, size: 25),
        const SizedBox(height: 6),
        Text(value, style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ]),
    );
  }
}
