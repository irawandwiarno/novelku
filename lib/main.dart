import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:novelku/app/modules/home/home.dart';
import 'package:novelku/app/pakage.dart';
import 'package:novelku/app/routes/app_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterQuillExtensions.useSuperClipboardPlugin();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NovelKu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppPages.pages,
      initialBinding: HomeBinding(),
      home: HomeView(),
    );
  }
}