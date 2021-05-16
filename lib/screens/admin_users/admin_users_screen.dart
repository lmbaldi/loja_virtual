import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/helpers/helpers.dart';
import 'package:provider/provider.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';
import '../../common/common.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(R.string.users),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            indexedHeight: (index) => 80,
            strList: adminUsersManager.names,
            highlightTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            showPreview: true,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  adminUsersManager.users[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  adminUsersManager.users[index].email,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: (){
                  context.read<AdminOrdersManager>().setUserFilter(adminUsersManager.users[index]);
                  context.read<PageManager>().setPage(5);
                },
              );
            },
          );
        },
      ),
    );
  }
}
