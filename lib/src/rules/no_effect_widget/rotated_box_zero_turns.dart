import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class RotatedBoxZeroTurns extends DartLintRule {
  RotatedBoxZeroTurns() : super(code: _code);

  static const _code = LintCode(
    name: 'rotated_box_zero_turns',
    problemMessage:
        'Do not use RotatedBox with quarterTurns 0. It does not rotate the child.',
    correctionMessage: 'Remove the RotatedBox widget.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'RotatedBox') {
        return;
      }

      final quarterTurns = _argument(node, 'quarterTurns');
      if (quarterTurns == null || !_isIntegerZero(quarterTurns.expression)) {
        return;
      }

      reporter.atNode(quarterTurns, code);
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

  bool _isIntegerZero(Expression expression) {
    return expression is IntegerLiteral && expression.value == 0;
  }
}
