import 'package:fluent_ui/fluent_ui.dart';
import 'package:works_book_web/screens/group.dart';
import 'package:works_book_web/widgets/app_bar_title.dart';
import 'package:works_book_web/widgets/custom_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: const AppBarTitle('お仕事手帳 - 管理画面'),
        actions: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: CustomIconButton(
              iconData: FluentIcons.settings,
              onPressed: () {},
            ),
          ),
        ),
      ),
      pane: NavigationPane(
        selected: selectedIndex,
        onChanged: (index) {
          setState(() => selectedIndex = index);
        },
        displayMode: PaneDisplayMode.top,
        items: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.calendar),
            title: const Text('会社・組織管理'),
            body: const GroupScreen(),
          ),
          PaneItemSeparator(),
        ],
      ),
    );
  }
}
