import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ExpandedFlexOne extends DartLintRule {
  ExpandedFlexOne() : super(code: _code);

  static const _code = LintCode(
    name: 'expanded_flex_one',
    problemMessage:
        'Do not set flex to 1 on Expanded. The default value is already 1.',
    correctionMessage: 'Remove the flex parameter.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'Expanded') {
        return;
      }

      final flex = _argument(node, 'flex');
      if (flex == null || !_isIntegerOne(flex.expression)) {
        return;
      }

      reporter.atNode(flex, code);
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

  bool _isIntegerOne(Expression expression) {
    return expression is IntegerLiteral && expression.value == 1;
  }
}
