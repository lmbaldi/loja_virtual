import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/components/app_theme.dart';
import 'package:loja_virtual/ui/page_manager/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final int page;

  const DrawerTile({this.iconData, this.title, this.page});

  @override
  Widget build(BuildContext context) {

    final int currentPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              iconData,
              size: 32,
              color: currentPage == page ?  primaryColor : Colors.grey[700],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: currentPage == page ? primaryColor : Colors.grey[700],
            ),
          )
        ],
      ),
    );
  }
}
