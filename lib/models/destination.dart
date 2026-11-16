class Destination {
  final String id;
  final String name;
  final String country;
  final String description;
  final String imageUrl;
  final double rating;
  final int price;
  final List<String> tags;

  const Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.tags,
  });
}

final List<Destination> sampleDestinations = [
  const Destination(
    id: '1', name: 'กรุงเทพฯ', country: 'ไทย',
    description: 'เมืองหลวงที่คึกคักของไทย เต็มไปด้วยวัดวาอาราม อาหารริมทาง และชีวิตยามค่ำคืนที่ไม่รู้จบ',
    imageUrl: 'https://picsum.photos/seed/bangkok/800/600', rating: 4.7,
    price: 50, tags: ['วัด', 'อาหาร', 'ช้อปปิ้ง'],
  ),
  const Destination(
    id: '2', name: 'เชียงใหม่', country: 'ไทย',
    description: 'เมืองทางเหนือที่ล้อมรอบด้วยภูเขา วัดโบราณ และวัฒนธรรมล้านนา',
    imageUrl: 'https://picsum.photos/seed/chiangmai/800/600', rating: 4.8,
    price: 35, tags: ['ธรรมชาติ', 'วัฒนธรรม', 'Trekking'],
  ),
  const Destination(
    id: '3', name: 'ภูเก็ต', country: 'ไทย',
    description: 'เกาะที่สวยงามของไทย มีหาดทรายขาว น้ำทะเลใส และกิจกรรมดำน้ำ',
    imageUrl: 'https://picsum.photos/seed/phuket/800/600', rating: 4.6,
    price: 80, tags: ['ทะเล', 'ดำน้ำ', 'รีสอร์ท'],
  ),
  const Destination(
    id: '4', name: 'โตเกียว', country: 'ญี่ปุ่น',
    description: 'มหานครที่ผสมผสานความทันสมัยและวัฒนธรรมดั้งเดิมได้อย่างลงตัว',
    imageUrl: 'https://picsum.photos/seed/tokyo/800/600', rating: 4.9,
    price: 120, tags: ['เทคโนโลยี', 'อาหาร', 'อนิเมะ'],
  ),
  const Destination(
    id: '5', name: 'บาหลี', country: 'อินโดนีเซีย',
    description: 'เกาะแห่งพระเจ้า เต็มไปด้วยวัดและชายหาดสวยงาม',
    imageUrl: 'https://picsum.photos/seed/bali/800/600', rating: 4.7,
    price: 60, tags: ['วัฒนธรรม', 'ทะเล', 'Yoga'],
  ),
  const Destination(
    id: '6', name: 'สิงคโปร์', country: 'สิงคโปร์',
    description: 'นครรัฐที่สะอาด ทันสมัย และปลอดภัย มีอาหารหลากหลายวัฒนธรรม',
    imageUrl: 'https://picsum.photos/seed/singapore/800/600', rating: 4.8,
    price: 150, tags: ['ช้อปปิ้ง', 'อาหาร', 'สวนสนุก'],
  ),
];

Destination? destinationById(String? id) {
  for (final destination in sampleDestinations) {
    if (destination.id == id) return destination;
  }
  return null;
}
