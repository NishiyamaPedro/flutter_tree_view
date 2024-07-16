import 'package:flutter/material.dart';

import 'node.dart';

typedef TreeNodeItemBuilder<T extends NodeMixin> = TreeNodeItem Function(
    Node<T> data);

class TreeNodeItem {
  final Widget title;
  final Widget? trailing;
  final Widget? subtitle;

  TreeNodeItem({
    required this.title,
    this.trailing,
    this.subtitle,
  });
}

class TreeNode<T extends NodeMixin> extends StatelessWidget {
  final Node<T> node;
  final TreeNodeItemBuilder<T> itemBuilder;

  const TreeNode({
    super.key,
    required this.node,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final itemInfo = itemBuilder(node);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: CustomPaint(
        painter: TreeLines(),
        child: (node.children != null)
            ? ExpansionTile(
                title: itemInfo.title,
                subtitle: itemInfo.subtitle,
                trailing: itemInfo.trailing,
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                tilePadding: const EdgeInsets.only(left: 8.0),
                shape: LinearBorder.none,
                children: [
                  for (var child in node.children ?? [])
                    if (child.isVisible)
                      TreeNode(
                        node: child,
                        itemBuilder: itemBuilder,
                      )
                ],
              )
            : ListTile(
                title: itemInfo.title,
                subtitle: itemInfo.subtitle,
                trailing: itemInfo.trailing,
                dense: true,
                onTap: () {},
              ),
      ),
    );
  }
}

class TreeLines extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        const Offset(0, 0),
        Offset(0, size.height),
        Paint()
          ..strokeWidth = 1
          ..color = Colors.grey);

    canvas.drawLine(
        const Offset(0, 20.0),
        const Offset(8.0, 20.0),
        Paint()
          ..strokeWidth = 1
          ..color = Colors.grey);
  }

  @override
  bool shouldRepaint(TreeLines oldDelegate) => false;
}
