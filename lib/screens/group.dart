import 'package:fluent_ui/fluent_ui.dart';
import 'package:works_book_web/models/group.dart';
import 'package:works_book_web/services/group.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  GroupService groupService = GroupService();
  List<GroupModel> groups = [];

  void _getGroups() async {
    List<GroupModel> tmpGroups = await groupService.selectList();
    if (mounted) {
      setState(() => groups = tmpGroups);
    }
  }

  @override
  void initState() {
    super.initState();
    _getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '会社・組織データを一覧で表示します。契約があった場合は、ここで新規登録してください。',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
