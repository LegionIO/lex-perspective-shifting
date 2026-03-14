# lex-perspective-shifting

Multi-stakeholder perspective analysis for the LegionIO cognitive architecture. Generates and synthesizes multiple viewpoints on situations to support balanced decision making.

## What It Does

Maintains a library of named perspectives (stakeholder, emotional, temporal, cultural, ethical, etc.) and situations. Views are generated on situations from each perspective, capturing valence, concerns, and opportunities. Agreement, coverage, blind spots, and divergent pairs are analyzed. Synthesis produces a confidence-weighted aggregate view.

## Usage

```ruby
client = Legion::Extensions::PerspectiveShifting::Client.new

# Register perspectives
client.add_perspective(name: 'end_user', type: :stakeholder, priorities: [:safety, :efficiency], empathy: 0.8)
client.add_perspective(name: 'adversarial', type: :adversarial, priorities: [:exploitation], empathy: 0.2)

# Define a situation
result = client.add_situation(content: 'Deploy new authentication system')
sit_id = result[:situation_id]

# Generate views
persp_ids = client.list_perspectives[:perspectives].map { |p| p[:id] }
client.generate_view(situation_id: sit_id, perspective_id: persp_ids[0],
                     valence: 0.7, concerns: ['migration friction'],
                     opportunities: ['stronger security'], confidence: 0.8)
client.generate_view(situation_id: sit_id, perspective_id: persp_ids[1],
                     valence: -0.3, concerns: ['new attack surface'], confidence: 0.6)

# Synthesize
client.synthesize(situation_id: sit_id)
# => { weighted_valence: 0.3, concerns: ['migration friction', 'new attack surface'],
#      opportunities: ['stronger security'], agreement: 0.6, agreement_label: :mixed,
#      coverage_score: 1.0, coverage_label: :comprehensive }

# Check coverage gaps
client.blind_spots(situation_id: sit_id)
# => { blind_spots: [:emotional, :temporal, :cultural, :ethical, :pragmatic, :creative], count: 6 }
```

## Perspective Types

`:stakeholder`, `:emotional`, `:temporal`, `:cultural`, `:ethical`, `:pragmatic`, `:creative`, `:adversarial`

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
