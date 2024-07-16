mixin NodeMixin {
  late String id;
  String? parentId;
  String? locationId;

  // Get the non-null id, they will never be non-null at the same time.
  String? get effectiveId => parentId ?? locationId;
}

class Node<T extends NodeMixin> {
  final String? id;
  final Node<T>? parent;
  final T? data;

  List<Node<T>>? children;

  bool? isTextSimilar;

  bool? _isVisible;
  set isVisible(bool? value) {
    // Do not change if true. A child should probably have it set.
    // To reset this we can pass null.
    if (_isVisible != true || value == null) _isVisible = value;

    // Try setting the isVisible of the parent.
    if (value != null) parent?.isVisible = value;
  }

  bool get isVisible => _isVisible ?? true;
  bool get shouldExpand => _isVisible == true;

  Node([this.id, this.parent, this.data]);

  factory Node.fromList(List nodes) {
    // Create the root of the tree and define it on the map.
    final root = Node<T>();
    final Map<String?, Node<T>> nodeMap = {
      null: root,
    };

    // Defined in this scope to facilitate access to the node map.
    void parseDepth(List toParse) {
      // Exit the loop if toParse is empty.
      if (toParse.isEmpty) return;

      List next = [];
      for (T item in toParse) {
        // If we find the parent on the map, we create a new node and add it to the map.
        // If not, we add the item to the next pass.
        if (nodeMap.containsKey(item.effectiveId)) {
          final node = Node<T>(item.id, nodeMap[item.effectiveId], item);

          nodeMap[item.id] = node;
          nodeMap[item.effectiveId]?.addChild(node);
        } else {
          next.add(item);
        }
      }
      parseDepth(next);
    }

    parseDepth(nodes);

    // We sort the tree so that the nodes with the most children come first.
    sortTree(root);

    return root;
  }

  void addChild(Node<T> child) {
    children ??= [];
    children?.add(child);
  }

  static void sortTree(Node root) {
    if (root.children == null) return;

    // Sort by number of children
    root.children?.sort(
        (a, b) => (b.children?.length ?? 0).compareTo(a.children?.length ?? 0));

    for (var node in root.children!) {
      sortTree(node);
    }
  }
}
