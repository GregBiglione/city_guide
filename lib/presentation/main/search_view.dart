import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../ressource/string_manager.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(AppString.search).tr(),
    );
  }
}
