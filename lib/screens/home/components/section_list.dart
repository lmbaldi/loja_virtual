import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/data.dart';
import 'component.dart';

class SectionList extends StatelessWidget {
  final Section section;

  SectionList(this.section);

  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(),
            SizedBox(
              height: 120,
              child: Consumer<Section>(
                builder: (_, section, __){
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      if(index < section.items.length)
                        return ItemTile(section.items[index]);
                      else
                        return AddTileWidget();
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      width: 4,
                    ),
                    itemCount: homeManager.editing
                        ? section.items.length + 1
                        : section.items.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
