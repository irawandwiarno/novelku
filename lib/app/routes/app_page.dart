import 'package:novelku/app/modules/add_novel/add_novel.dart';
import 'package:novelku/app/modules/home/home.dart';
import 'package:novelku/app/modules/novel/novel.dart';
import 'package:novelku/app/modules/workspace/workspace.dart';
import 'package:novelku/app/pakage.dart';
import 'package:novelku/app/routes/route_name.dart';


class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteName.workspace,
      page: () => WSView(),
    ),
    GetPage(
      name: RouteName.addNovel,
      page: () => AddNovelPage(),
      binding: AddnovBinding(),
    ),
    GetPage(
      name: RouteName.novel,
      page: () => NovelView(),
      binding: NovelBinding(),
    ),
  ];
}