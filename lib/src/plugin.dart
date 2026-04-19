import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:flutter_semantic_lints/src/rules/conflicting_parameter/box_decoration_color_gradient.dart';
import 'package:flutter_semantic_lints/src/rules/conflicting_parameter/container_color_decoration.dart';
import 'package:flutter_semantic_lints/src/rules/no_effect_widget/opacity_one.dart';
import 'package:flutter_semantic_lints/src/rules/useless_parameter/expanded_flex_one.dart';

class FlutterSemanticLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        BoxDecorationColorGradient(),
        ContainerColorDecoration(),
        ExpandedFlexOne(),
        OpacityOne(),
      ];
}
