import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class TransformScaleOne extends DartLintRule {
  TransformScaleOne() : super(code: _code);

  static const _code = LintCode(
    name: 'transform_scale_one',
    problemMessage:
        'Do not use Transform.scale with scale 1.0. It does not change the child.',
    correctionMessage: 'Remove the Transform widget.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'Transform' ||
          _constructorName(node) != 'scale') {
        return;
      }

      final scale = _argument(node, 'scale');
      if (scale == null || !_isOne(scale.expression)) {
        return;
      }

      reporter.atNode(scale, code);
    });
  }

  String _constructorTypeName(InstanceCreationExpression node) {
    return node.constructorName.type.name.lexeme;
  }

  String? _constructorName(InstanceCreationExpression node) {
    return node.constructorName.name?.name;
  }

  NamedExpression? _argument(InstanceCreationExpression node, String name) {
    for (final argument in node.argumentList.arguments) {
      if (argument is NamedExpression && argument.name.label.name == name) {
        return argument;
      }
    }
    return null;
  }

  bool _isOne(Expression expression) {
    if (expression is IntegerLiteral) {
      return expression.value == 1;
    }
    if (expression is DoubleLiteral) {
      return expression.value == 1.0;
    }
    return false;
  }
}
