import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:works_book_web/common/style.dart';
import 'package:works_book_web/providers/auth.dart';
import 'package:works_book_web/screens/group.dart';
import 'package:works_book_web/screens/login.dart';
import 'package:works_book_web/widgets/app_bar_title.dart';
import 'package:works_book_web/widgets/custom_button.dart';
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
    final authProvider = Provider.of<AuthProvider>(context);

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
              onPressed: () => showDialog(
                context: context,
                builder: (context) => SignOutDialog(
                  authProvider: authProvider,
                ),
              ),
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

class SignOutDialog extends StatefulWidget {
  final AuthProvider authProvider;

  const SignOutDialog({
    required this.authProvider,
    super.key,
  });

  @override
  State<SignOutDialog> createState() => _SignOutDialogState();
}

class _SignOutDialogState extends State<SignOutDialog> {
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text(
        'システム情報',
        style: TextStyle(fontSize: 18),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('最終更新日: 2023/07/04 15:49'),
          Text('ログインID: owner'),
        ],
      ),
      actions: [
        CustomButton(
          labelText: '閉じる',
          labelColor: kWhiteColor,
          backgroundColor: kGreyColor,
          onPressed: () => Navigator.pop(context),
        ),
        CustomButton(
          labelText: 'ログアウト',
          labelColor: kWhiteColor,
          backgroundColor: kRedColor,
          onPressed: () async {
            await widget.authProvider.signOut();
            if (!mounted) return;
            Navigator.pushReplacement(
              context,
              FluentPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
