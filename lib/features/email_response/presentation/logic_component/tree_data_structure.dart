class TreeNode {
  String data;
  bool _isActive = false;
  ParentNode? parent;

  TreeNode({
    required this.data,
    this.parent,
  });

  bool get isActive => _isActive;

  set isActive(bool value) {
    if (_isActive == value) return;

    if (value) {
      parent?.activateChild(this);
    }

    _isActive = value;
  }
}

class ParentNode {
  String defaultData = '';
  TreeNode? activeChild;
  final List<TreeNode> children;

  ParentNode() : children = [];

  void addChild(TreeNode child) {
    child.parent = this;
    children.add(child);
  }

  void activateChild(TreeNode child) {
    if (activeChild == child) return;

    if (activeChild != null) {
      activeChild!._isActive = false;
    }

    child._isActive = true;
    activeChild = child;
  }
}
