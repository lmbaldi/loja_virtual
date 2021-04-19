import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/helpers/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  final IconData iconData;
  final String title;
  final int page;

  const DrawerTile({this.iconData, this.title, this.page});

  @override
  Widget build(BuildContext context) {
    //obtem a pagina atual
    final int currentPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              iconData,
              size: 32,
              color: currentPage == page ? primaryColor  : Colors.grey[700],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: currentPage == page ? primaryColor : Colors.grey[700]
            ),
          )
        ],
      ),
    );
  }
}
