import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class EmptySizedBox extends DartLintRule {
  EmptySizedBox() : super(code: _code);

  static const _code = LintCode(
    name: 'empty_sized_box',
    problemMessage:
        'Do not use SizedBox without width, height, or child. It has no effect.',
    correctionMessage:
        'Remove the SizedBox or use SizedBox.shrink() when a placeholder is intended.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'SizedBox') {
        return;
      }
      if (_constructorName(node) != null) {
        return;
      }
      if (node.argumentList.arguments.isNotEmpty) {
        return;
      }

      reporter.atNode(node, code);
    });
  }

  String _constructorTypeName(InstanceCreationExpression node) {
    return node.constructorName.type.name.lexeme;
  }

  String? _constructorName(InstanceCreationExpression node) {
    return node.constructorName.name?.name;
  }
}
