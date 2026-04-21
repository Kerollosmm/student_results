# BOOTSTRAP PROMPT — paste this at the start of every Gemini CLI session

```
اقرأ الملفين GEMINI.md و TASKS.md الموجودين في المجلد الحالي بالكامل قبل ما تعمل أي حاجة.

أنت Flutter developer بتبني Student Results App.
الـ data بيجي من Excel file محلي موجود في assets/data/student_results.xlsx — مفيش Firebase مفيش internet.

بعد ما تقرأ الملفين:
1. قولي إيه الـ Phase اللي هنبدأ منها
2. ابدأ Phase 1 خطوة خطوة
3. بعد كل خطوة، اسألني هل أكمل ولا في مشكلة

لا تبدأ تكتب كود قبل ما تأكدلي إنك قرأت الـ GEMINI.md وفهمت الـ data model.
```

---

# PHASE PROMPTS — استخدمهم لو Gemini وقف أو نسي السياق

## لو وقف في Excel parsing:
```
في GEMINI.md في section "Excel Datasource — Key Logic" فيه الكود بالظبط.
المشكلة الشائعة: Excel package بيقرأ الأرقام كـ double (1001.0).
الحل: استخدم .split('.')[0] أو .replaceAll(RegExp(r'\.0$'), '')
لما تعمل مقارنة بين cardId المدخل وcardId من Excel.
```

## لو نسي RTL:
```
الـ app لازم يكون RTL بالكامل:
1. MaterialApp: locale: const Locale('ar')
2. builder: Directionality(textDirection: TextDirection.rtl, child: child!)
3. كل TextField: textDirection: TextDirection.rtl, textAlign: TextAlign.right
4. font: GoogleFonts.cairoTextTheme()
```

## لو الـ build_runner فشل:
```
شغّل:
flutter pub run build_runner build --delete-conflicting-outputs

لو لسه فيه error في generated files، امسح الـ .g.dart و .freezed.dart files وشغّل تاني.
```

## لو GetIt مش شايل الـ repository:
```
تأكد إن ResultsRepositoryImpl عندها:
@Injectable(as: ResultsRepository)

وإن ExcelDatasource عندها:
@injectable

وإن injection.dart عنده:
@InjectableInit()
void configureDependencies() => getIt.init();
```

## لو GoRouter مش شغال:
```
في ResultsScreen، الـ student object بيتبعت كـ extra:
context.go('/results', extra: student)

في الـ route:
builder: (_, state) => ResultsScreen(student: state.extra as StudentResult)
```
