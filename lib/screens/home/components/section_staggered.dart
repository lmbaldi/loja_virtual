import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../data/data.dart';
import 'component.dart';

class SectionStaggered extends StatelessWidget {
  final Section section;

  SectionStaggered(this.section);

  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: homeManager.editing
              ? section.items.length + 1
              : section.items.length,
            itemBuilder: (_, index) {
              if(index < section.items.length)
                return ItemTile(section.items[index]);
              else
                return AddTileWidget();
            },
            staggeredTileBuilder: (index) =>
              StaggeredTile.count(2, index.isEven ? 2 : 1),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
          ),
        ],
      ),
    );
  }
}
