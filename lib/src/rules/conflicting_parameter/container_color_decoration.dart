import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ContainerColorDecoration extends DartLintRule {
  ContainerColorDecoration() : super(code: _code);

  static const _code = LintCode(
    name: 'container_color_decoration',
    problemMessage:
        'Do not use both color and decoration in Container. Color conflicts with decoration.',
    correctionMessage:
        'Move color into the decoration or remove one parameter.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'Container') {
        return;
      }

      final color = _argument(node, 'color');
      final decoration = _argument(node, 'decoration');
      if (color == null || decoration == null) {
        return;
      }
      if (_isNullLiteral(color.expression) ||
          _isNullLiteral(decoration.expression)) {
        return;
      }

      reporter.atNode(decoration, code);
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
