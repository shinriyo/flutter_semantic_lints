/// Custom lint rules that detect semantically meaningless Flutter code.
///
/// This package focuses on conflicting parameters, useless parameters, and
/// no-effect widgets. It does not provide style, naming, formatting, or
/// architecture rules.
library;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:flutter_semantic_lints/src/plugin.dart';

/// Creates the custom_lint plugin for `flutter_semantic_lints`.
PluginBase createPlugin() => FlutterSemanticLintsPlugin();
