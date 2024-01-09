import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:works_book_web/common/style.dart';
import 'package:works_book_web/models/group.dart';
import 'package:works_book_web/screens/group_source.dart';
import 'package:works_book_web/services/group.dart';
import 'package:works_book_web/widgets/custom_button.dart';
import 'package:works_book_web/widgets/custom_cell.dart';
import 'package:works_book_web/widgets/custom_data_grid.dart';
import 'package:works_book_web/widgets/custom_icon_text_button.dart';
import 'package:works_book_web/widgets/custom_text_box.dart';

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '契約された会社・組織データを一覧で表示します。契約があった場合は、ここで新規登録してください。',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconTextButton(
                      iconData: FluentIcons.add,
                      iconColor: kWhiteColor,
                      labelText: '新規登録',
                      labelColor: kWhiteColor,
                      backgroundColor: kBlueColor,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AddGroupDialog(
                          getGroups: _getGroups,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 650,
                  child: CustomDataGrid(
                    source: GroupSource(
                      context: context,
                      groups: groups,
                      getGroups: _getGroups,
                    ),
                    columns: [
                      GridColumn(
                        columnName: 'number',
                        label: const CustomCell(label: '会社・組織番号'),
                      ),
                      GridColumn(
                        columnName: 'name',
                        label: const CustomCell(label: '会社・組織名'),
                      ),
                      GridColumn(
                        columnName: 'zipCode',
                        label: const CustomCell(label: '郵便番号'),
                      ),
                      GridColumn(
                        columnName: 'address',
                        label: const CustomCell(label: '住所'),
                      ),
                      GridColumn(
                        columnName: 'tel',
                        label: const CustomCell(label: '電話番号'),
                      ),
                      GridColumn(
                        columnName: 'email',
                        label: const CustomCell(label: 'メールアドレス'),
                      ),
                      GridColumn(
                        columnName: 'image',
                        label: const CustomCell(label: '画像'),
                      ),
                      GridColumn(
                        columnName: 'edit_favorites',
                        label: const CustomCell(label: '操作'),
                        width: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddGroupDialog extends StatefulWidget {
  final Function() getGroups;

  const AddGroupDialog({
    required this.getGroups,
    super.key,
  });

  @override
  State<AddGroupDialog> createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<AddGroupDialog> {
  GroupService groupService = GroupService();
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text(
        '会社・組織 - 新規登録',
        style: TextStyle(fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoLabel(
            label: '会社・組織番号',
            child: CustomTextBox(
              controller: numberController,
              keyboardType: TextInputType.number,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          InfoLabel(
            label: '会社・組織名',
            child: CustomTextBox(
              controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          InfoLabel(
            label: '郵便番号',
            child: CustomTextBox(
              controller: zipCodeController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          InfoLabel(
            label: '住所',
            child: CustomTextBox(
              controller: addressController,
              keyboardType: TextInputType.streetAddress,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          InfoLabel(
            label: '電話番号',
            child: CustomTextBox(
              controller: telController,
              keyboardType: TextInputType.phone,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          InfoLabel(
            label: 'メールアドレス',
            child: CustomTextBox(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          InfoLabel(
            label: 'パスワード',
            child: CustomTextBox(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              maxLines: 1,
              obscureText: true,
            ),
          ),
        ],
      ),
      actions: [
        CustomButton(
          labelText: 'キャンセル',
          labelColor: kWhiteColor,
          backgroundColor: kGreyColor,
          onPressed: () => Navigator.pop(context),
        ),
        CustomButton(
          labelText: '登録する',
          labelColor: kWhiteColor,
          backgroundColor: kBlueColor,
          onPressed: () async {
            GroupModel? group = await groupService.select(
              numberController.text,
            );
            if (group != null) return;
            String id = groupService.id();
            groupService.create({
              'id': id,
              'number': numberController.text,
              'name': nameController.text,
              'zipCode': zipCodeController.text,
              'address': addressController.text,
              'tel': telController.text,
              'email': emailController.text,
              'password': passwordController.text,
              'createdAt': DateTime.now(),
            });
            widget.getGroups();
            if (!mounted) return;
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
