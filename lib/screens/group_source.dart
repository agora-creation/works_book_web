import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:works_book_web/common/style.dart';
import 'package:works_book_web/models/group.dart';
import 'package:works_book_web/services/group.dart';
import 'package:works_book_web/widgets/custom_button.dart';
import 'package:works_book_web/widgets/custom_cell.dart';
import 'package:works_book_web/widgets/custom_image_cell.dart';
import 'package:works_book_web/widgets/custom_input_image.dart';
import 'package:works_book_web/widgets/custom_text_box.dart';

class GroupSource extends DataGridSource {
  final BuildContext context;
  final List<GroupModel> groups;
  final Function() getGroups;

  GroupSource({
    required this.context,
    required this.groups,
    required this.getGroups,
  }) {
    buildDataGridRows();
  }

  List<DataGridRow> dataGridRows = [];

  void buildDataGridRows() {
    dataGridRows = groups.map<DataGridRow>((group) {
      return DataGridRow(cells: [
        DataGridCell(
          columnName: 'number',
          value: group.number,
        ),
        DataGridCell(
          columnName: 'name',
          value: group.name,
        ),
        DataGridCell(
          columnName: 'zipCode',
          value: group.zipCode,
        ),
        DataGridCell(
          columnName: 'address',
          value: group.address,
        ),
        DataGridCell(
          columnName: 'tel',
          value: group.tel,
        ),
        DataGridCell(
          columnName: 'email',
          value: group.email,
        ),
        DataGridCell(
          columnName: 'image',
          value: group.image,
        ),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor = Colors.transparent;
    if ((rowIndex % 2) == 0) {
      backgroundColor = kWhiteColor;
    }
    List<Widget> cells = [];
    GroupModel group = groups.singleWhere(
      (e) => e.number == '${row.getCells()[0].value}',
    );
    cells.add(CustomCell(label: '${row.getCells()[0].value}'));
    cells.add(CustomCell(label: '${row.getCells()[1].value}'));
    cells.add(CustomCell(label: '${row.getCells()[2].value}'));
    cells.add(CustomCell(label: '${row.getCells()[3].value}'));
    cells.add(CustomCell(label: '${row.getCells()[4].value}'));
    cells.add(CustomCell(label: '${row.getCells()[5].value}'));
    cells.add(CustomImageCell(image: '${row.getCells()[6].value}'));
    cells.add(Row(
      children: [
        CustomButton(
          labelText: '編集',
          labelColor: kWhiteColor,
          backgroundColor: kBlueColor,
          onPressed: () => showDialog(
            context: context,
            builder: (context) => ModGroupDialog(
              group: group,
              getGroups: getGroups,
            ),
          ),
        ),
      ],
    ));
    return DataGridRowAdapter(color: backgroundColor, cells: cells);
  }

  @override
  Future<void> handleLoadMoreRows() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
    GridTableSummaryRow summaryRow,
    GridSummaryColumn? summaryColumn,
    RowColumnIndex rowColumnIndex,
    String summaryValue,
  ) {
    Widget? widget;
    Widget buildCell(
      String value,
      EdgeInsets padding,
      Alignment alignment,
    ) {
      return Container(
        padding: padding,
        alignment: alignment,
        child: Text(value, softWrap: false),
      );
    }

    widget = buildCell(
      summaryValue,
      const EdgeInsets.all(4),
      Alignment.centerLeft,
    );
    return widget;
  }

  void updateDataSource() {
    notifyListeners();
  }
}

class ModGroupDialog extends StatefulWidget {
  final GroupModel group;
  final Function() getGroups;

  const ModGroupDialog({
    required this.group,
    required this.getGroups,
    super.key,
  });

  @override
  State<ModGroupDialog> createState() => _ModGroupDialogState();
}

class _ModGroupDialogState extends State<ModGroupDialog> {
  GroupService groupService = GroupService();
  TextEditingController nameController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Uint8List? pickedImage;

  void _init() {
    setState(() {
      nameController.text = widget.group.name;
      zipCodeController.text = widget.group.zipCode;
      addressController.text = widget.group.address;
      telController.text = widget.group.tel;
      emailController.text = widget.group.email;
      passwordController.text = widget.group.password;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text(
        '会社・組織 - 編集',
        style: TextStyle(fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoLabel(
            label: '会社・組織番号',
            child: Text(widget.group.number),
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
          const SizedBox(height: 8),
          InfoLabel(
            label: '画像',
            child: CustomInputImage(
              url: widget.group.image,
              picked: pickedImage,
              onTap: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result != null) {
                  setState(() {
                    pickedImage = result.files.first.bytes;
                  });
                }
              },
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
          labelText: '保存する',
          labelColor: kWhiteColor,
          backgroundColor: kBlueColor,
          onPressed: () async {
            String image = widget.group.image;
            if (pickedImage != null) {
              storage.UploadTask uploadTask;
              storage.Reference ref = storage.FirebaseStorage.instance
                  .ref()
                  .child('group')
                  .child('/${widget.group.number}.jpeg');
              final metadata =
                  storage.SettableMetadata(contentType: 'image/jpeg');
              uploadTask = ref.putData(pickedImage!, metadata);
              await uploadTask.whenComplete(() => null);
              image = await ref.getDownloadURL();
            }
            groupService.update({
              'id': widget.group.id,
              'name': nameController.text,
              'zipCode': zipCodeController.text,
              'address': addressController.text,
              'tel': telController.text,
              'email': emailController.text,
              'password': passwordController.text,
              'image': image,
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
