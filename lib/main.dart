import 'package:flutter/material.dart';

void main() {
  runApp(const PEAlgeriaApp());
}

class PEAlgeriaApp extends StatefulWidget {
  const PEAlgeriaApp({super.key});

  @override
  State<PEAlgeriaApp> createState() => _PEAlgeriaAppState();
}

class _PEAlgeriaAppState extends State<PEAlgeriaApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'حقيبة أستاذ التربية البدنية',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: HomeScreen(
        isDarkMode: isDarkMode,
        onToggleTheme: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

class LessonMemo {
  final String number;
  final String title;
  final String unit;
  final String objective;
  final String equipment;
  final String warmUp;
  final String mainPart;
  final String coolDown;

  LessonMemo({
    required this.number,
    required this.title,
    required this.unit,
    required this.objective,
    required this.equipment,
    required this.warmUp,
    required this.mainPart,
    required this.coolDown,
  });
}

class GradeLevel {
  final String name;
  final String shortNum;
  final String annualPlan;
  final List<String> units;
  final List<LessonMemo> memos;

  GradeLevel({
    required this.name,
    required this.shortNum,
    required this.annualPlan,
    required this.units,
    required this.memos,
  });
}

final List<GradeLevel> curriculumData = [
  GradeLevel(
    name: 'السنة الأولى ابتدائي',
    shortNum: '1 AP',
    annualPlan:
        '• الميدان الأول: الوضعية والتنقل (المشي، الجري، التوازن).\n'
        '• الميدان الثاني: الحركات القاعدية (الرمي، الوثب، التخطي).\n'
        '• الميدان الثالث: الألعاب الجماعية التمهيدية والتعاون.',
    units: [
      'الوحدة 01: التنقلات الأساسية والتوازن',
      'الوحدة 02: الرمي والتصويب نحو أهداف',
      'الوحدة 03: الألعاب الجماعية التمهيدية',
    ],
    memos: [
      LessonMemo(
        number: '01',
        title: 'المشي والجري في فضاءات مختلفة',
        unit: 'الوحدة 01: التنقلات الأساسية',
        objective: 'ضبط إيقاع الجري وتفادي الاصطدام بالزملاء داخل فضاء محدد.',
        equipment: 'أقماع، حلقات، صافرة، صدريات ملونة.',
        warmUp: 'لعبة القطار السريع: المشي ثم الهرولة الخفيفة حول الملعب مع تغيير الاتجاه عند الصافرة (10 د).',
        mainPart: 'ورشة الحواجز المنخفضة: الجري المتعرج بين الأقماع والقفز داخل الحلقات في أفواج (25 د).',
        coolDown: 'لعبة التمثال: التوقف التام عند الإشارة مع تمارين التنفس العميق (5 د).',
      ),
      LessonMemo(
        number: '02',
        title: 'التوازن على خط مستقيم',
        unit: 'الوحدة 01: التنقلات الأساسية',
        objective: 'الحفاظ على توازن الجسم أثناء التنقل على مسار ضيق.',
        equipment: 'حبال أرضية، أكياس رملية صغيرة، أقماع.',
        warmUp: 'تسخين المفاصل مع لعبة تقليد حركة الحيوانات (10 د).',
        mainPart: 'المشي فوق حبل ممدود على الأرض ذهاباً وإياباً مع حمل كيس رملي فوق الرأس (25 د).',
        coolDown: 'الجلوس في دائرة وتمارين إطالة خفيفة للرجلين والظهر (5 د).',
      ),
    ],
  ),
  GradeLevel(
    name: 'السنة الثانية ابتدائي',
    shortNum: '2 AP',
    annualPlan:
        '• الميدان الأول: تطوير التناسق الحركي والجري السريع.\n'
        '• الميدان الثاني: الوثب الطويل والعلوي البسيط.\n'
        '• الميدان الثالث: التمرير والاستقبال باليد ضمن مجموعات.',
    units: [
      'الوحدة 01: الجري السريع وتخطي الحواجز',
      'الوحدة 02: الوثب بأنواعه',
      'الوحدة 03: التمرير والاستقبال',
    ],
    memos: [
      LessonMemo(
        number: '01',
        title: 'الانطلاق السريع عند الإشارة',
        unit: 'الوحدة 01: الجري السريع',
        objective: 'الاستجابة السريعة للإشارة السمعية والبصرية والانطلاق في خط مستقيم.',
        equipment: 'أقماع، صافرة، رايات ملونة.',
        warmUp: 'الجري الخفيف مع حركات الذراعين وتنبيهات سمعية للتوقف والانطلاق (10 د).',
        mainPart: 'سباقات قصيرة لمسافة 15 متر من وضعيات انطلاق مختلفة (الوقوف، الجلوس) (25 د).',
        coolDown: 'المشي البطيء مع تمارين الاسترخاء (5 د).',
      ),
    ],
  ),
  GradeLevel(
    name: 'السنة الثالثة ابتدائي',
    shortNum: '3 AP',
    annualPlan: 'بناء التصرفات القاعدية في الجري، الرمي، والمنافسات الثنائية وتطبيق قواعد الأمن.',
    units: ['الوحدة 01: سباقات التتابع', 'الوحدة 02: الرمي لبعيد', 'الوحدة 03: ألعاب المواجهة'],
    memos: [],
  ),
  GradeLevel(
    name: 'السنة الرابعة ابتدائي',
    shortNum: '4 AP',
    annualPlan: 'تنظيم التنقلات الفردية والجماعية وتطبيق قوانين الألعاب المصغرة والتعاون مع الزملاء.',
    units: ['الوحدة 01: الجري السريع والمقاومة', 'الوحدة 02: ألعاب الكرة المصغرة', 'الوحدة 03: الجمباز الأرضي البسيط'],
    memos: [],
  ),
  GradeLevel(
    name: 'السنة الخامسة ابتدائي',
    shortNum: '5 AP',
    annualPlan: 'التحكم في المهارات الحركية المركبة والتحضير للمنافسات المدرسية والعمل الجماعي المنظم.',
    units: ['الوحدة 01: ألعاب القوى (جري، وثب، رمي)', 'الوحدة 02: الرياضات الجماعية المصغرة', 'الوحدة 03: التوجيه والتنقل'],
    memos: [],
  ),
];

String teacherName = 'أستاذ التربية البدنية';
String schoolName = 'المدرسة الابتدائية';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _editProfile() {
    final nameCtrl = TextEditingController(text: teacherName);
    final schoolCtrl = TextEditingController(text: schoolName);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تخصيص ترويسة المذكرات'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'اسم ولقب الأستاذ')),
            const SizedBox(height: 10),
            TextField(controller: schoolCtrl, decoration: const InputDecoration(labelText: 'اسم المدرسة الابتدائية')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              setState(() {
                if (nameCtrl.text.trim().isNotEmpty) teacherName = nameCtrl.text.trim();
                if (schoolCtrl.text.trim().isNotEmpty) schoolName = schoolCtrl.text.trim();
              });
              Navigator.pop(ctx);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حقيبة التربية البدنية'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.edit_note),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(radius: 26, child: Icon(Icons.sports_soccer, size: 30)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(teacherName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(schoolName, style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.edit), onPressed: _editProfile),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: curriculumData.length,
              itemBuilder: (context, index) {
                final grade = curriculumData[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      child: Text(grade.shortNum, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(grade.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    subtitle: Text('${grade.units.length} وحدات تعليمية • ${grade.memos.length} مذكرات'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => GradeScreen(grade: grade)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GradeScreen extends StatelessWidget {
  final GradeLevel grade;

  const GradeScreen({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
