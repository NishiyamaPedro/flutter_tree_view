import 'package:flutter/material.dart';

import 'node.dart';
import 'tree_node.dart';

class TreeView<T extends NodeMixin> extends StatelessWidget {
  final Node<T> root;
  final TreeNodeItemBuilder<T> itemBuilder;

  const TreeView({
    super.key,
    required this.root,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          for (Node<T> child in root.children ?? [])
            if (child.isVisible)
              TreeNode<T>(
                node: child,
                itemBuilder: itemBuilder,
              )
        ],
      ),
    );
  }
}
