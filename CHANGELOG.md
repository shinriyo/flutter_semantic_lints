## 0.1.4

- Add no-effect widget rule:
  - `empty_sized_box`
- Add positive, negative, and edge cases for `empty_sized_box`.
- Document skipped candidates separately from implemented rules.

## 0.1.3

- Add useless parameter rules:
  - `visibility_visible_true`
  - `edge_insets_all_zero`
  - `border_radius_circular_zero`
- Add no-effect widget rules:
  - `padding_zero`
  - `transform_scale_one`
  - `rotated_box_zero_turns`
- Add positive, negative, and edge cases for the new rules.

## 0.1.2

- Add pub.dev link to README.
- Add localized README files for Japanese, Korean, Vietnamese, and Chinese.
- Exclude the example custom_lint analyzer plugin config from the published archive.
- Add dartdoc comments for the public library API.
- Keep the example custom_lint analyzer plugin config as an opt-in template.
- Document per-rule custom_lint configuration.
- Add localized README files for Portuguese, Hindi mixed with English, Indonesian, Turkish, Spanish, and Arabic.

## 0.1.1

- Exclude the example project from package-level static analysis.
- Keep custom_lint integration checks in the example project for CI and local testing.

## 0.1.0

- Initial release.
- Add custom_lint plugin registration.
- Add conflicting parameter rules:
  - `box_decoration_color_gradient`
  - `container_color_decoration`
- Add useless parameter rule:
  - `expanded_flex_one`
- Add no-effect widget rule:
  - `opacity_one`
- Add example project with positive, negative, and edge cases.
