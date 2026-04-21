import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PaddingZero extends DartLintRule {
  PaddingZero() : super(code: _code);

  static const _code = LintCode(
    name: 'padding_zero',
    problemMessage:
        'Do not use Padding with EdgeInsets.zero. It does not add spacing.',
    correctionMessage: 'Remove the Padding widget.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (_constructorTypeName(node) != 'Padding') {
        return;
      }

      final padding = _argument(node, 'padding');
      if (padding == null || !_isNamedConstant(padding.expression)) {
        return;
      }

      reporter.atNode(padding, code);
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

  bool _isNamedConstant(Expression expression) {
    if (expression is PrefixedIdentifier) {
      return expression.prefix.name == 'EdgeInsets' &&
          expression.identifier.name == 'zero';
    }
    if (expression is PropertyAccess && expression.target is SimpleIdentifier) {
      final target = expression.target as SimpleIdentifier;
      return target.name == 'EdgeInsets' &&
          expression.propertyName.name == 'zero';
    }
    return false;
  }
}
