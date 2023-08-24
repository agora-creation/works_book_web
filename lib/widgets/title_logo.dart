import 'package:fluent_ui/fluent_ui.dart';
import 'package:works_book_web/common/style.dart';

class TitleLogo extends StatelessWidget {
  const TitleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 100,
        ),
        const Text(
          'お仕事手帳',
          style: TextStyle(
            color: kBaseColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        const Text(
          'WORKS BOOK',
          style: TextStyle(
            color: kGreyColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}
