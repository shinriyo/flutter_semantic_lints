import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:flutter_semantic_lints/src/rules/conflicting_parameter/box_decoration_color_gradient.dart';
import 'package:flutter_semantic_lints/src/rules/conflicting_parameter/container_color_decoration.dart';
import 'package:flutter_semantic_lints/src/rules/no_effect_widget/empty_sized_box.dart';
import 'package:flutter_semantic_lints/src/rules/no_effect_widget/opacity_one.dart';
import 'package:flutter_semantic_lints/src/rules/no_effect_widget/padding_zero.dart';
import 'package:flutter_semantic_lints/src/rules/no_effect_widget/rotated_box_zero_turns.dart';
import 'package:flutter_semantic_lints/src/rules/no_effect_widget/transform_scale_one.dart';
import 'package:flutter_semantic_lints/src/rules/useless_parameter/border_radius_circular_zero.dart';
import 'package:flutter_semantic_lints/src/rules/useless_parameter/edge_insets_all_zero.dart';
import 'package:flutter_semantic_lints/src/rules/useless_parameter/expanded_flex_one.dart';
import 'package:flutter_semantic_lints/src/rules/useless_parameter/visibility_visible_true.dart';

class FlutterSemanticLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        BoxDecorationColorGradient(),
        ContainerColorDecoration(),
        BorderRadiusCircularZero(),
        EdgeInsetsAllZero(),
        ExpandedFlexOne(),
        VisibilityVisibleTrue(),
        EmptySizedBox(),
        OpacityOne(),
        PaddingZero(),
        RotatedBoxZeroTurns(),
        TransformScaleOne(),
      ];
}
