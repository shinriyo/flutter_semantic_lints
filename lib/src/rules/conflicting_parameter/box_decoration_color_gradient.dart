import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class BoxDecorationColorGradient extends DartLintRule {
  BoxDecorationColorGradient() : super(code: _code);

  static const _code = LintCode(
    name: 'box_decoration_color_gradient',
    problemMessage:
        'Do not use both color and gradient in BoxDecoration. Color is ignored when gradient is set.',
    correctionMessage: 'Remove color or gradient.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'BoxDecoration') {
        return;
      }

      final color = _argument(node, 'color');
      final gradient = _argument(node, 'gradient');
      if (color == null || gradient == null) {
        return;
      }
      if (_isNullLiteral(color.expression) ||
          _isNullLiteral(gradient.expression)) {
        return;
      }

      reporter.atNode(gradient, code);
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

  bool _isNullLiteral(Expression expression) => expression is NullLiteral;
}
