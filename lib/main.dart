import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const PeBagAlgeriaApp());
}

class PeBagAlgeriaApp extends StatefulWidget {
  const PeBagAlgeriaApp({super.key});

  @override
  State<PeBagAlgeriaApp> createState() => _PeBagAlgeriaAppState();
}

class _PeBagAlgeriaAppState extends State<PeBagAlgeriaApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'حقيبة التربية البدنية',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF00796B),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF00796B),
        brightness: Brightness.dark,
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

class MemoModel {
  final String id;
  final String level;
  final String unit;
  final String title;
  final String objective;
  final String warmup;
  final String mainPart;
  final String coolDown;

  const MemoModel({
    required this.id,
    required this.level,
    required this.unit,
    required this.title,
    required this.objective,
    required this.warmup,
    required this.mainPart,
    required this.coolDown,
  });
}

final List<MemoModel> initialMemos = [
  // ================= السنة الأولى (L1) =================
  MemoModel(
    id: 'l1_u1_m1',
    level: 'L1',
    unit: 'الوضعيات والتنقلات - استكشاف الفضاء',
    title: 'التنقل في الفضاء واحترام الحدود',
    objective:
        'أن يتعرف المتعلم على فضاء اللعب ويتنقل فيه دون اصطدام مع احترام الإشارة الصوتية أو البصرية.',
    warmup:
        'مشي حر في الساحة مع رفع الذراعين والوقوف عند سماع الصفارة (6 دقائق).',
    mainPart:
        'لعبة "السيارات والمرآب": يتنقل التلاميذ بحرية داخل المساحة المحددة، وعند الإشارة يتوقفون أو يدخلون "المرآب" المحدد بأقماع.',
    coolDown: 'مشي بطيء مع تمارين تنفس عميق واسترخاء الكتفين في دائرة.',
  ),
  MemoModel(
    id: 'l1_u1_m2',
    level: 'L1',
    unit: 'الوضعيات والتنقلات - تغيير الاتجاه',
    title: 'المشي والجري وتغيير الاتجاه',
    objective:
        'أن يغير المتعلم اتجاه تنقله وسرعته استجابة لإشارة بسيطة مع الحفاظ على التوازن.',
    warmup: 'مشي متبوع بخبب خفيف ودوران الذراعين أمامًا وخلفًا (6 دقائق).',
    mainPart:
        'مسلك بسيط من أقماع وحلقات: يجري التلميذ بخطوات منتظمة، يمر داخل الحلقات، ثم يغير اتجاهه نحو القمع الملون.',
    coolDown: 'جلوس مريح ومدّ الساقين مع زفير هادئ.',
  ),
  MemoModel(
    id: 'l1_u2_m1',
    level: 'L1',
    unit: 'الحركات القاعدية - الرمي والوثب',
    title: 'رمي الكرات الخفيفة والوثب البسيط',
    objective:
        'أن يرمي المتعلم كرة خفيفة نحو هدف قريب ويوثب برجلين فوق عائق منخفض.',
    warmup: 'حركات تسخين للمفاصل الكبرى ووثب خفيف في المكان (6 دقائق).',
    mainPart:
        'ورشة ثنائية: رمي كرات إسفنجية أو خفيفة داخل سلة/طوق قريب، يليها وثب متتابع بكلتا القدمين فوق حبال منخفضة.',
    coolDown: 'مشي هادئ وهزّ الأطراف لإزالة التوتر العضلي.',
  ),

  // ================= السنة الثانية (L2) =================
  MemoModel(
    id: 'l2_u1_m1',
    level: 'L2',
    unit: 'الوضعيات والتنقلات - التوازن والتوجيه',
    title: 'التوازن الديناميكي على خط ومسارات متعرجة',
    objective:
        'أن يحافظ المتعلم على توازنه أثناء السير على خط مستقيم أو متعرج دون فقدان المسار.',
    warmup: 'مشي على أطراف الأصابع ثم على الكعبين مع تحريك الذراعين (7 دقائق).',
    mainPart:
        'مسار التوازن: السير على خط مرسوم أو عارضة منخفضة مع حمل كيس صغير فوق الرأس أو الكف دون إسقاطه.',
    coolDown:
        'تمارين إطالة خفيفة للعضلات الخلفية للفخذ والساق مع تهدئة التنفس.',
  ),
  MemoModel(
    id: 'l2_u2_m1',
    level: 'L2',
    unit: 'الحركات القاعدية - الجري والرمي',
    title: 'السرعة ورد الفعل والرمي الموجه',
    objective:
        'أن يستجيب المتعلم بسرعة لإشارة الانطلاق ويرمي نحو هدف محدد بدقة متزايدة.',
    warmup:
        'جري خفيف في مجموعات وركض في المكان مع رفع الركبتين تدريجيًا (7 دقائق).',
    mainPart:
        'لعبة "السباق نحو الهدف": الانطلاق من وضع الوقوف عند الإشارة للجري مسافة قصيرة ورمي كيس نحو منطقة محددة.',
    coolDown: 'مشي بطيء في الساحة مع خفض تدريجي لوتيرة الحركة.',
  ),

  // ================= السنة الثالثة (L3) =================
  MemoModel(
    id: 'l3_u1_m1',
    level: 'L3',
    unit: 'الوضعيات والتنقلات - تنظيم الفضاء والوتيرة',
    title: 'تكييف سرعة التنقل وتجنب المنافس',
    objective:
        'أن يضبط المتعلم سرعة جريه وتغيير اتجاهه لتفادي اللمس ضمن فضاء لعب محدد.',
    warmup: 'جري متدرج السرعة مع حركات تعبئة مفصلية وديناميكية (8 دقائق).',
    mainPart:
        'لعبة "الصيادون والغزلان" في مساحة محددة: يتنقل اللاعبون ويغيرون اتجاهاتهم بسرعة لتفادي اللمس مع احترام قواعد اللعب النظيف.',
    coolDown: 'مشي استرجاعي وتمارين تمدد لطيفة للظهر والكتفين.',
  ),
  MemoModel(
    id: 'l3_u2_m1',
    level: 'L3',
    unit: 'الحركات القاعدية - الوثب والرمي',
    title: 'الوثب الطويل من الاقتراب والرمي بكلتا اليدين',
    objective:
        'أن يربط المتعلم بين اقتراب قصير والارتقاء للوثب للأمام، ويرمي كرة متوسطة نحو زميل.',
    warmup: 'جري خفيف، وثبات متتالية قصيرة، ودوران الجذع والذراعين (8 دقائق).',
    mainPart:
        'محطتان بالتناوب: (1) اقتراب بـ 3–4 خطوات والوثب بكلتا القدمين داخل منطقة هبوط؛ (2) تمرير واستقبال كرة متوسطة في ثنائيات.',
    coolDown: 'جلوس واسترخاء عضلي مع تنفس منتظم.',
  ),

  // ================= السنة الرابعة (L4) =================
  MemoModel(
    id: 'l4_u1_m1',
    level: 'L4',
    unit: 'الحركات القاعدية - الجري والوثب',
    title: 'الجري السريع وتمرير الشاهد أو الكرة',
    objective:
        'أن يحافظ المتعلم على استقامة الجري في خط مستقيم وينفذ تمريرًا دقيقًا أثناء الحركة.',
    warmup:
        'إحماء عام متدرج مع تمارين تفعيل عضلي وسرعات تصاعدية قصيرة (8 دقائق).',
    mainPart:
        'سباق تتابع مبسط في أفواج: يجري المتعلم في مساره المحدد ويسلّم الكرة/الشاهد للزميل داخل منطقة التسليم المنظمة.',
    coolDown: 'مشي هادئ وإطالة عضلات الفخذ الأمامية والخلفية.',
  ),
  MemoModel(
    id: 'l4_u2_m1',
    level: 'L4',
    unit: 'الألعاب والوضعيات الجماعية المبسطة',
    title: 'التمركز واللعب الجماعي البسيط (3 ضد 3)',
    objective:
        'أن يتحرك المتعلم لطلب الكرة في مساحة مفتوحة ويتعاون مع زملائه للوصول إلى الهدف.',
    warmup: 'تمرير في مجموعات ثلاثية مع التنقل بعد التمرير (8 دقائق).',
    mainPart:
        'مباراة مصغرة مبسطة (3 ضد 3) بدون احتكاك قوي: التركيز على التمرير، التحرك لفتح زاوية، واحترام دور الدفاع والهجوم.',
    coolDown: 'جمع الصف، تقييم سريع للمواقف، وتمارين استرخاء.',
  ),

  // ================= السنة الخامسة (L5) =================
  MemoModel(
    id: 'l5_u1_m1',
    level: 'L5',
    unit: 'الحركات القاعدية - التحمل والسرعة والرمي',
    title: 'تنظيم الجهد في الجري والرمي نحو هدف بعيد',
    objective:
        'أن يوزع المتعلم جهده بانتظام أثناء الجري وينفذ رمية منسقة نحو هدف أبعد.',
    warmup:
        'إحماء متكامل يشمل الجري المنتظم، حركات التنسيق الحركي، وتحضير الكتفين (9 دقائق).',
    mainPart:
        'مسلك مركب: جري منتظم الإيقاع لمسافة متوسطة، يليه رمي كرة/كيس نحو هدف مرقّم مع احتساب النقاط حسب الدقة.',
    coolDown: 'مشي بطيء وتمارين إطالة شاملة للأطراف والجذع.',
  ),
  MemoModel(
    id: 'l5_u2_m1',
    level: 'L5',
    unit: 'الألعاب الجماعية والوضعيات التكتيكية البسيطة',
    title: 'قراءة اللعب والتعاون الجماعي في الفضاء',
    objective:
        'أن يتخذ المتعلم قرار التمرير أو التقدم المناسب حسب وضعية الزملاء والمنافسين.',
    warmup:
        'ألعاب إحماء جماعية تعتمد على الانتباه والسرعة ورد الفعل (9 دقائق).',
    mainPart:
        'وضعية لعب جماعية مصغرة (4 ضد 4) بقوانين مبسطة: تشجيع التمرير البيني، الدعم بعد التمرير، والالتزام بالروح الرياضية.',
    coolDown: 'تهدئة عامة، تمارين تنفس، وختام الحصة.',
  ),
];

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
  String teacherName = 'أستاذ التربية البدنية والرياضية';
  String schoolName = 'المؤسسة التربوية';
    final levels = const 

    {'code': 'L1', 'label': 'السنة الأولى'},
    {'code': 'L2', 'label': 'السنة الثانية'},
    {'code': 'L3', 'label': 'السنة الثالثة'},
    {'code': 'L4', 'label': 'السنة الرابعة'},
    {'code': 'L5', 'label': 'السنة الخامسة'},
  ];

  int _countMemos(String levelCode) {
    return memos.where((m) => m.level == levelCode).length;
  }

  void _editProfile() {
    final nameController = TextEditingController(text: teacherName);
    final schoolController = TextEditingController(text: schoolName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('بيانات الأستاذ والمؤسسة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(labelText: 'الاسم الكامل / الصفة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: schoolController,
              decoration: const InputDecoration(labelText: 'المؤسسة التربوية'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                if (nameController.text.trim().isNotEmpty) {
                  teacherName = nameController.text.trim();
                }
                if (schoolController.text.trim().isNotEmpty) {
                  schoolName = schoolController.text.trim();
                }
              });
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _addMemoDialog(String defaultLevel) {
    String selectedLevel = defaultLevel;
    final unitController = TextEditingController();
    final titleController = TextEditingController();
    final objectiveController = TextEditingController();
    final warmupController = TextEditingController();
    final mainController = TextEditingController();
    final coolDownController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('إضافة مذكرة جديدة'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedLevel,
                  decoration: const InputDecoration(labelText: 'السنة الدراسية'),
                  items: levels
                      .map(
                        (lvl) => DropdownMenuItem(
                          value: lvl['code'],
                          child: Text('${lvl['label']} (${lvl['code']})'),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setDialogState(() => selectedLevel = val);
                    }
                  },
                ),
                TextField(
                  controller: unitController,
                  decoration:
                      const InputDecoration(labelText: 'الوحدة / الميدان'),
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'عنوان المذكرة'),
                ),
                TextField(
                  controller: objectiveController,
                  decoration: const InputDecoration(labelText: 'الهدف التعلمي'),
                  maxLines: 2,
                ),
                TextField(
                  controller: warmupController,
                  decoration:
                      const InputDecoration(labelText: 'المرحلة التحضيرية'),
                  maxLines: 2,
                ),
                TextField(
                  controller: mainController,
                  decoration:
                      const InputDecoration(labelText: 'المرحلة التعليمية'),
                  maxLines: 3,
                ),
                TextField(
                  controller: coolDownController,
                  decoration:
                      const InputDecoration(labelText: 'المرحلة الختامية'),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) return;
                setState(() {
                  memos.add(
                    MemoModel(
                      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                      level: selectedLevel,
                      unit: unitController.text.trim().isEmpty
                          ? 'وحدة تعليمية'
                          : unitController.text.trim(),
                      title: titleController.text.trim(),
                      objective: objectiveController.text.trim().isEmpty
                          ? 'تحقيق الكفاءة الحركية المستهدفة.'
                          : objectiveController.text.trim(),
                      warmup: warmupController.text.trim().isEmpty
                          ? 'تحضير بدني وحركي متدرج.'
                          : warmupController.text.trim(),
                      mainPart: mainController.text.trim().isEmpty
                          ? 'وضعيات تعليمية وألعاب موجهة.'
                          : mainController.text.trim(),
                      coolDown: coolDownController.text.trim().isEmpty
                          ? 'عودة للهدوء واسترخاء.'
                          : coolDownController.text.trim(),
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'حقيبة التربية البدنية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          onPressed: widget.onToggleTheme,
          tooltip: 'تبديل الوضع',
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addMemoDialog('L1'),
        icon: const Icon(Icons.add),
        label: const Text('مذكرة جديدة'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: _editProfile,
                  icon: Icon(Icons.edit, color: colorScheme.onPrimaryContainer),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        teacherName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        schoolName,
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              colorScheme.onPrimaryContainer.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: colorScheme.primary,
                  child:
                      Icon(Icons.sports_soccer, color: colorScheme.onPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...levels.map((lvl) {
            final code = lvl['code']!;
            final label = lvl['label']!;
            final count = _countMemos(code);

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: const Icon(Icons.chevron_left),
                title: Text(
                  label,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '$count مذكرات متوفرة',
                  textAlign: TextAlign.right,
                ),
                trailing: CircleAvatar(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  child: Text(
                    code,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LevelMemosScreen(
                        levelCode: code,
                        levelLabel: label,
                        teacherName: teacherName,
                        schoolName: schoolName,
                        memos: memos.where((m) => m.level == code).toList(),
                        onAddMemo: () => _addMemoDialog(code),
                      ),
                    ),
                  );
                  setState(() {});
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class LevelMemosScreen extends StatelessWidget {
  final String levelCode;
  final String levelLabel;
  final String teacherName;
  final String schoolName;
  final List<MemoModel> memos;
  final VoidCallback onAddMemo;

  const LevelMemosScreen({
    super.key,
    required this.levelCode,
    required this.levelLabel,
    required this.teacherName,
    required this.schoolName,
    required this.memos,
    required this.onAddMemo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$levelLabel ($levelCode)'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddMemo,
        child: const Icon(Icons.add),
      ),
      body: memos.isEmpty
          ? const Center(child: Text('لا توجد مذكرات في هذا المستوى حالياً'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: memos.length,
              itemBuilder: (context, index) {
                final memo = memos[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      memo.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(memo.unit),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MemoDetailScreen(
                            memo: memo,
                            levelLabel: levelLabel,
                            teacherName: teacherName,
                            schoolName: schoolName,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class MemoDetailScreen extends StatelessWidget {
  final MemoModel memo;
  final String levelLabel;
  final String teacherName;
  final String schoolName;

  const MemoDetailScreen({
    super.key,
    required this.memo,
    required this.levelLabel,
    required this.teacherName,
    required this.schoolName,
  });

  Future<File> _generatePdfFile() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'مذكرة تربوية - $levelLabel (${memo.level})',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 6),
                pw.Text('المؤسسة: $schoolName | الأستاذ: $teacherName'),
                pw.Divider(),
                pw.Text('الوحدة / الميدان: ${memo.unit}'),
                pw.Text('الموضوع: ${memo.title}'),
                pw.SizedBox(height: 10),
                pw.Text('الهدف التعلمي: ${memo.objective}'),
                pw.SizedBox(height: 8),
                pw.Text('المرحلة التحضيرية: ${memo.warmup}'),
                pw.SizedBox(height: 8),
                pw.Text('المرحلة التعليمية: ${memo.mainPart}'),
                pw.SizedBox(height: 8),
                pw.Text('المرحلة الختامية: ${memo.coolDown}'),
              ],
            ),
          ),
        ),
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${memo.id}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memo.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final file = await _generatePdfFile();
              await Share.shareXFiles(
                [XFile(file.path)],
                text: '${memo.title} - $levelLabel',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              final file = await _generatePdfFile();
              await Printing.layoutPdf(
                onLayout: (_) async => await file.readAsBytes(),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionCard(context, 'الوحدة / الميدان', memo.unit),
          _sectionCard(context, 'الهدف التعلمي', memo.objective),
          _sectionCard(context, 'المرحلة التحضيرية', memo.warmup),
          _sectionCard(context, 'المرحلة التعليمية', memo.mainPart),
          _sectionCard(context, 'المرحلة الختامية', memo.coolDown),
        ],
      ),
    );
  }

  Widget _sectionCard(BuildContext context, String label, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(content, style: const TextStyle(height: 1.5)),
          ],
        ),
      ),
    );
  }
}
