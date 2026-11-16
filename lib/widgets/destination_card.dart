import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../models/saved_store.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;

  const DestinationCard({super.key, required this.destination, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      shadowColor: Colors.black12,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    destination.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => ColoredBox(
                      color: Colors.blueGrey.shade100,
                      child: const Icon(Icons.image_not_supported, size: 40),
                    ),
                  ),
                  // Checkpoint 3: Positioned ต้องอยู่ภายใน Stack จึงกำหนดมุมได้
                  // ถ้าเอา Positioned ออกไปนอก Stack จะเกิด ParentDataWidget error
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.65),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.star, color: Colors.amber, size: 15),
                          const SizedBox(width: 4),
                          Text('${destination.rating}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: AnimatedBuilder(
                      animation: savedStore,
                      builder: (context, _) {
                        final isSaved = savedStore.isSaved(destination.id);
                        return IconButton.filledTonal(
                          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                          visualDensity: VisualDensity.compact,
                          tooltip: isSaved ? 'ยกเลิกบันทึก' : 'บันทึก',
                          onPressed: () => savedStore.toggle(destination.id),
                          icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border,
                            color: isSaved ? Colors.red : null, size: 20),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(child: Text(destination.name,
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                      const SizedBox(width: 4),
                      Flexible(child: Text('\$${destination.price}/คืน',
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11,
                          color: Theme.of(context).colorScheme.primary))),
                    ]),
                    const SizedBox(height: 3),
                    Row(children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 3),
                      Expanded(child: Text(destination.country, maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: Colors.grey))),
                    ]),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          spacing: 3, runSpacing: 3,
                          children: destination.tags.take(2).map((tag) =>
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8)),
                              child: Text(tag, maxLines: 1,
                                style: const TextStyle(fontSize: 10, color: Colors.blue)),
                            )).toList(),
                        ),
                      ),
                    ),
                    // Checkpoint 3: Expanded ให้ข้อความเหลือพื้นที่อย่างปลอดภัยใน Row
                    Row(children: const [
                      Icon(Icons.bed, size: 15, color: Colors.green),
                      SizedBox(width: 4),
                      Expanded(child: Text('พร้อมเข้าพัก', maxLines: 1,
                        overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11))),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
