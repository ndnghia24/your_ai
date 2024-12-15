import 'package:your_ai/features/email_response/domain/entities/enum_mail_category.dart';
import 'package:your_ai/features/email_response/presentation/logic_component/tree_data_structure.dart';

class CategoryTree {
  late ParentNode lengthTree;
  late ParentNode fomalityTree;
  late ParentNode toneTree;
  late ParentNode languageTree;

  CategoryTree() {
    initlengthTree();
    initFomalityTree();
    initToneTree();
    initlanguageTree();
  }

  void initlengthTree() {
    lengthTree = ParentNode();
    lengthTree.addChild(TreeNode(data: EmailStyle.length.short));
    lengthTree.addChild(TreeNode(data: EmailStyle.length.medium));
    lengthTree.addChild(TreeNode(data: EmailStyle.length.long));

    // set default active child
    lengthTree.activeChild = lengthTree.children[0];
  }

  void initFomalityTree() {
    fomalityTree = ParentNode();
    fomalityTree.addChild(TreeNode(data: EmailStyle.formality.casual));
    fomalityTree.addChild(TreeNode(data: EmailStyle.formality.neutral));
    fomalityTree.addChild(TreeNode(data: EmailStyle.formality.formal));

    // set default active child
    fomalityTree.activeChild = fomalityTree.children[0];
  }

  void initToneTree() {
    toneTree = ParentNode();
    toneTree.addChild(TreeNode(data: EmailStyle.tone.witty));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.direct));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.personable));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.informational));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.friendly));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.confident));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.sincere));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.enthusiastic));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.optimistic));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.concerned));
    toneTree.addChild(TreeNode(data: EmailStyle.tone.empathetic));

    // set default active child
    toneTree.activeChild = toneTree.children[0];
  }

  void initlanguageTree() {
    languageTree = ParentNode();
    languageTree.addChild(TreeNode(data: EmailStyle.language.vietnamese));
    languageTree.addChild(TreeNode(data: EmailStyle.language.english));

    // set default active child
    languageTree.activeChild = languageTree.children[0];
  }

  // getters
  String get lengthOptions =>
      lengthTree.activeChild?.data ?? lengthTree.defaultData;
  String get formatOptions =>
      fomalityTree.activeChild?.data ?? lengthTree.defaultData;
  String get toneOptions =>
      toneTree.activeChild?.data ?? lengthTree.defaultData;
}
