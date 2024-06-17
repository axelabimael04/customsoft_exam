import 'package:flutter/cupertino.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return CupertinoSearchTextField(
      controller: searchController,
      padding: const EdgeInsets.all(10),
      keyboardType: TextInputType.name,
      onChanged: (String value) {},
      onSubmitted: (String value) {},
    );
  }
}
