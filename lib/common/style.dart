import 'package:fluent_ui/fluent_ui.dart';

const kBackColor = Color(0xFFF4F5F7);
const kBaseColor = Color(0xFF3F51B5);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF333333);
const kGreyColor = Color(0xFF9E9E9E);
const kGrey2Color = Color(0xFF757575);
const kGrey3Color = Color(0xFFCCCCCC);
const kRedColor = Color(0xFFF44336);
const kBlueColor = Color(0xFF2196F3);
const kOrangeColor = Color(0xFFFF9800);

FluentThemeData customTheme() {
  return FluentThemeData(
    fontFamily: 'SourceHanSansJP-Regular',
    activeColor: kBaseColor,
    cardColor: kWhiteColor,
    scaffoldBackgroundColor: kBackColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    navigationPaneTheme: const NavigationPaneThemeData(
      backgroundColor: kWhiteColor,
      highlightColor: kBaseColor,
    ),
    checkboxTheme: CheckboxThemeData(
      checkedDecoration: ButtonState.all<Decoration>(
        BoxDecoration(
          color: kBackColor,
          border: Border.all(color: kBaseColor),
        ),
      ),
      uncheckedDecoration: ButtonState.all<Decoration>(
        BoxDecoration(
          color: kBackColor,
          border: Border.all(color: kBaseColor),
        ),
      ),
    ),
  );
}
