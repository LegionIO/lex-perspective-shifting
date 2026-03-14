# lex-perspective-shifting

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-perspective-shifting`
- **Version**: 0.1.0
- **Namespace**: `Legion::Extensions::PerspectiveShifting`

## Purpose

Multi-stakeholder perspective analysis. Maintains named perspectives (each with a type, priorities, empathy level, expertise domains, and optional bias) and situations. Generates views on situations from each perspective, then synthesizes them via confidence-weighted valence aggregation. Detects blind spots, coverage gaps, agreement level, and the most divergent pair of views.

## Gem Info

- **Homepage**: https://github.com/LegionIO/lex-perspective-shifting
- **License**: MIT
- **Ruby**: >= 3.4

## File Structure

```
lib/legion/extensions/perspective_shifting/
  version.rb
  client.rb
  helpers/
    constants.rb          # Types, labels, limits; empathy_label/coverage_label/agreement_label module_functions
    perspective.rb        # Perspective class — named viewpoint with type, priorities, empathy
    perspective_view.rb   # PerspectiveView class — view of situation from perspective
    shifting_engine.rb    # ShiftingEngine — manages perspectives, situations, views
  runners/
    perspective_shifting.rb  # Runner module
spec/
  helpers/constants_spec.rb
  helpers/perspective_spec.rb
  helpers/perspective_view_spec.rb
  helpers/shifting_engine_spec.rb
  runners/perspective_shifting_spec.rb
  client_spec.rb
```

## Key Constants

From `Helpers::Constants`:
- `MAX_PERSPECTIVES = 50`, `MAX_SITUATIONS = 200`, `MAX_VIEWS_PER_SITUATION = 20`
- `DEFAULT_EMPATHY = 0.5`, `MIN_PERSPECTIVES_FOR_SYNTHESIS = 2`
- `PERSPECTIVE_TYPES = %i[stakeholder emotional temporal cultural ethical pragmatic creative adversarial]`
- `PRIORITY_TYPES = %i[safety efficiency fairness innovation stability growth autonomy compliance]`
- `EMPATHY_LABELS`: `:deeply_empathic` (0.8+), `:empathic`, `:moderate`, `:limited`, `:detached`
- `COVERAGE_LABELS`: `:comprehensive`, `:thorough`, `:partial`, `:narrow`, `:blind`
- `AGREEMENT_LABELS`: `:consensus`, `:agreement`, `:mixed`, `:disagreement`, `:conflict`

## Runners

All runners accept optional `engine:` parameter to inject a custom `ShiftingEngine` (useful for testing).

| Method | Key Parameters | Returns |
|---|---|---|
| `add_perspective` | `name:`, `type:`, `priorities:`, `empathy:`, `bias:`, `expertise_domains:` | `{ perspective: p.to_h }` |
| `list_perspectives` | — | `{ perspectives:, count: }` |
| `get_perspective` | `perspective_id:` | `{ found:, perspective: }` |
| `add_situation` | `content:` | `{ situation_id:, content: }` |
| `list_situations` | — | `{ situations:, count: }` |
| `generate_view` | `situation_id:`, `perspective_id:`, `valence:`, `concerns:`, `opportunities:`, `confidence:` | `{ view: v.to_h }` |
| `views_for_situation` | `situation_id:` | `{ views:, count: }` |
| `perspective_agreement` | `situation_id:` | `{ agreement:, label: }` |
| `blind_spots` | `situation_id:` | `{ blind_spots: [missing perspective types], count: }` |
| `coverage_score` | `situation_id:` | `{ coverage:, label: }` |
| `dominant_view` | `situation_id:` | highest-confidence view |
| `synthesize` | `situation_id:` | weighted valence + combined concerns/opportunities + agreement |
| `most_divergent_pair` | `situation_id:` | `{ views: [a, b], divergence: }` |
| `engine_status` | — | `engine.to_h` |

## Helpers

### `Helpers::Perspective`
Named viewpoint: `id`, `name`, `perspective_type`, `priorities`, `empathy_level`, `expertise_domains`, `bias_toward`. Validates type against `PERSPECTIVE_TYPES`.

### `Helpers::PerspectiveView`
A single perspective's take on a situation: `id`, `situation_id`, `perspective_id`, `valence` (-1–1), `concerns`, `opportunities`, `confidence` (0–1).

### `Helpers::ShiftingEngine`
`add_perspective` validates type. `generate_view` validates both IDs and view count. `perspective_agreement` = 1 - std_dev of valences. `blind_spots` = `PERSPECTIVE_TYPES` minus applied perspective types for that situation. `coverage_score` = applied unique perspectives / total perspectives. `synthesize` = confidence-weighted average valence + merged concerns/opportunities.

## Integration Points

- `synthesize` output (weighted valence, concerns, opportunities) can feed `lex-planning` for multi-stakeholder decision making
- `blind_spots` highlights missing viewpoints for `lex-reflection` meta-cognition
- `add_perspective(type: :adversarial)` models adversarial thinking for security scenarios
- `perspective_agreement` can feed `lex-conflict` when disagreement is high

## Development Notes

- `perspective_agreement` uses standard deviation of valences, normalized to [0,1]; agreement = 1 - std_dev
- `synthesize` requires at least 2 views; returns `{ error: :insufficient_views }` if not met
- `most_divergent_pair` uses `combination(2)` for O(n^2) pairwise comparison
- `coverage_score` = 0.0 if no perspectives registered (not just no views)
- `engine:` injection in all runner methods allows per-call engine isolation in tests
