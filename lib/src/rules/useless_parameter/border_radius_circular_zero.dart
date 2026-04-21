import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class BorderRadiusCircularZero extends DartLintRule {
  BorderRadiusCircularZero() : super(code: _code);

  static const _code = LintCode(
    name: 'border_radius_circular_zero',
    problemMessage:
        'Do not use BorderRadius.circular(0). BorderRadius.zero already represents no radius.',
    correctionMessage: 'Use BorderRadius.zero.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'BorderRadius' ||
          _constructorName(node) != 'circular') {
        return;
      }

      final arguments = node.argumentList.arguments;
      if (arguments.length != 1 || !_isZero(arguments.single)) {
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

  bool _isZero(Expression expression) {
    if (expression is IntegerLiteral) {
      return expression.value == 0;
    }
    if (expression is DoubleLiteral) {
      return expression.value == 0.0;
    }
    return false;
  }
}
