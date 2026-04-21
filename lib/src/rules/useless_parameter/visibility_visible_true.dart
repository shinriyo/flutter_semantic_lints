import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class VisibilityVisibleTrue extends DartLintRule {
  VisibilityVisibleTrue() : super(code: _code);

  static const _code = LintCode(
    name: 'visibility_visible_true',
    problemMessage:
        'Do not set visible to true on Visibility. The child is already visible.',
    correctionMessage: 'Remove the Visibility widget or make visible dynamic.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'Visibility') {
        return;
      }

      final visible = _argument(node, 'visible');
      if (visible == null || !_isBoolTrue(visible.expression)) {
        return;
      }

      reporter.atNode(visible, code);
    });
  }

  String _constructorTypeName(InstanceCreationExpression node) {
    return node.constructorName.type.name.lexeme;
  }

  NamedExpression? _argument(InstanceCreationExpression node, String name) {
    for (final argument in node.argumentList.arguments) {
      if (argument is NamedExpression && argument.name.label.name == name) {
        return argument;
      }
    }
    return null;
  }

  bool _isBoolTrue(Expression expression) {
    return expression is BooleanLiteral && expression.value;
  }
}
