class Wilaya {
  final int num;
  final String name;
  final String nameAr;

  const Wilaya({
    required this.num,
    required this.name,
    required this.nameAr,
  });

  // Convert from JSON
  factory Wilaya.fromJson(Map<String, dynamic> json) {
    return Wilaya(
      num: json['number'] as int,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'number': num,
      'name': name,
      'nameAr': nameAr,
    };
  }

  @override
  String toString() => 'Wilaya(num: $num, name: $name, nameAr: $nameAr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Wilaya && other.num == num;
  }

  @override
  int get hashCode => num.hashCode;
}

// Wilayas data manager class
class WilayasData {
  static const List<Map<String, dynamic>> _wilayasData = [
    {'number': 1, 'name': 'Adrar', 'nameAr': 'أدرار'},
    {'number': 2, 'name': 'Chlef', 'nameAr': 'الشلف'},
    {'number': 3, 'name': 'Laghouat', 'nameAr': 'الأغواط'},
    {'number': 4, 'name': 'Oum El Bouaghi', 'nameAr': 'أم البواقي'},
    {'number': 5, 'name': 'Batna', 'nameAr': 'باتنة'},
    {'number': 6, 'name': 'Béjaïa', 'nameAr': 'بجاية'},
    {'number': 7, 'name': 'Biskra', 'nameAr': 'بسكرة'},
    {'number': 8, 'name': 'Béchar', 'nameAr': 'بشار'},
    {'number': 9, 'name': 'Blida', 'nameAr': 'البليدة'},
    {'number': 10, 'name': 'Bouira', 'nameAr': 'البويرة'},
    {'number': 11, 'name': 'Tamanrasset', 'nameAr': 'تمنراست'},
    {'number': 12, 'name': 'Tébessa', 'nameAr': 'تبسة'},
    {'number': 13, 'name': 'Tlemcen', 'nameAr': 'تلمسان'},
    {'number': 14, 'name': 'Tiaret', 'nameAr': 'تيارت'},
    {'number': 15, 'name': 'Tizi Ouzou', 'nameAr': 'تيزي وزو'},
    {'number': 16, 'name': 'Algiers', 'nameAr': 'الجزائر'},
    {'number': 17, 'name': 'Djelfa', 'nameAr': 'الجلفة'},
    {'number': 18, 'name': 'Jijel', 'nameAr': 'جيجل'},
    {'number': 19, 'name': 'Sétif', 'nameAr': 'سطيف'},
    {'number': 20, 'name': 'Saïda', 'nameAr': 'سعيدة'},
    {'number': 21, 'name': 'Skikda', 'nameAr': 'سكيكدة'},
    {'number': 22, 'name': 'Sidi Bel Abbès', 'nameAr': 'سيدي بلعباس'},
    {'number': 23, 'name': 'Annaba', 'nameAr': 'عنابة'},
    {'number': 24, 'name': 'Guelma', 'nameAr': 'قالمة'},
    {'number': 25, 'name': 'Constantine', 'nameAr': 'قسنطينة'},
    {'number': 26, 'name': 'Médéa', 'nameAr': 'المدية'},
    {'number': 27, 'name': 'Mostaganem', 'nameAr': 'مستغانم'},
    {'number': 28, 'name': "M'Sila", 'nameAr': 'المسيلة'},
    {'number': 29, 'name': 'Mascara', 'nameAr': 'معسكر'},
    {'number': 30, 'name': 'Ouargla', 'nameAr': 'ورقلة'},
    {'number': 31, 'name': 'Oran', 'nameAr': 'وهران'},
    {'number': 32, 'name': 'El Bayadh', 'nameAr': 'البيض'},
    {'number': 33, 'name': 'Illizi', 'nameAr': 'إليزي'},
    {'number': 34, 'name': 'Bordj Bou Arréridj', 'nameAr': 'برج بوعريريج'},
    {'number': 35, 'name': 'Boumerdès', 'nameAr': 'بومرداس'},
    {'number': 36, 'name': 'El Tarf', 'nameAr': 'الطارف'},
    {'number': 37, 'name': 'Tindouf', 'nameAr': 'تندوف'},
    {'number': 38, 'name': 'Tissemsilt', 'nameAr': 'تيسمسيلت'},
    {'number': 39, 'name': 'El Oued', 'nameAr': 'الوادي'},
    {'number': 40, 'name': 'Khenchela', 'nameAr': 'خنشلة'},
    {'number': 41, 'name': 'Souk Ahras', 'nameAr': 'سوق أهراس'},
    {'number': 42, 'name': 'Tipaza', 'nameAr': 'تيبازة'},
    {'number': 43, 'name': 'Mila', 'nameAr': 'ميلة'},
    {'number': 44, 'name': 'Aïn Defla', 'nameAr': 'عين الدفلى'},
    {'number': 45, 'name': 'Naâma', 'nameAr': 'النعامة'},
    {'number': 46, 'name': 'Aïn Témouchent', 'nameAr': 'عين تموشنت'},
    {'number': 47, 'name': 'Ghardaïa', 'nameAr': 'غرداية'},
    {'number': 48, 'name': 'Relizane', 'nameAr': 'غليزان'},
    {'number': 49, 'name': 'Timimoun', 'nameAr': 'تيميمون'},
    {'number': 50, 'name': 'Bordj Badji Mokhtar', 'nameAr': 'برج باجي مختار'},
    {'number': 51, 'name': 'Ouled Djellal', 'nameAr': 'أولاد جلال'},
    {'number': 52, 'name': 'Béni Abbès', 'nameAr': 'بني عباس'},
    {'number': 53, 'name': 'In Salah', 'nameAr': 'عين صالح'},
    {'number': 54, 'name': 'In Guezzam', 'nameAr': 'عين قزام'},
    {'number': 55, 'name': 'Touggourt', 'nameAr': 'تقرت'},
    {'number': 56, 'name': 'Djanet', 'nameAr': 'جانت'},
    {'number': 57, 'name': 'El Meghaier', 'nameAr': 'المغير'},
    {'number': 58, 'name': 'El Meniaa', 'nameAr': 'المنيعة'},
  ];

  // Get all wilayas as Wilaya objects
  static List<Wilaya> get allWilayas {
    return _wilayasData.map((data) => Wilaya.fromJson(data)).toList();
  }

  // Get wilaya by number
  static Wilaya? getWilayaByNumber(int number) {
    try {
      final data = _wilayasData.firstWhere((w) => w['number'] == number);
      return Wilaya.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  // Get wilaya by name (case insensitive)
  static Wilaya? getWilayaByName(String name) {
    try {
      final data = _wilayasData.firstWhere(
        (w) => w['name'].toString().toLowerCase() == name.toLowerCase(),
      );
      return Wilaya.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  // Search wilayas by name or Arabic name
  static List<Wilaya> searchWilayas(String query) {
    if (query.isEmpty) return allWilayas;
    
    final lowerQuery = query.toLowerCase();
    return allWilayas.where((wilaya) {
      return wilaya.name.toLowerCase().contains(lowerQuery) ||
             wilaya.nameAr.contains(query);
    }).toList();
  }

  // Get total count
  static int get totalCount => _wilayasData.length;
}
