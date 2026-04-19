import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class OpacityOne extends DartLintRule {
  OpacityOne() : super(code: _code);

  static const _code = LintCode(
    name: 'opacity_one',
    problemMessage:
        'Do not use Opacity with opacity 1.0. It has no visual effect and only adds cost.',
    correctionMessage: 'Remove the Opacity widget.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'Opacity') {
        return;
      }

      final opacity = _argument(node, 'opacity');
      if (opacity == null || !_isOne(opacity.expression)) {
        return;
      }

      reporter.atNode(opacity, code);
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
