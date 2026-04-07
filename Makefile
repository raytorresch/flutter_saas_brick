# flutter_saas_brick — brick management commands

.PHONY: get hooks analyze use use-config bundle publish

# Resolve the local brick (run once, or after changes to brick.yaml)
get:
	mason get

# Install hook dependencies
hooks:
	cd hooks && dart pub get

# Analyze hooks
analyze: hooks
	cd hooks && dart analyze --fatal-infos

# Generate interactively — prompts for every variable
# Usage:
#   make use               → outputs to ./output
#   make use dir=../myapp  → outputs to a custom path
use: get
	mason make flutter_saas_brick \
		-o $(or $(dir),./output) \
		--on-conflict overwrite

# Generate from config.json (no prompts)
# Setup: cp config.example.json config.json  →  edit config.json  →  make use-config
# Usage:
#   make use-config               → outputs to ./output
#   make use-config dir=../myapp  → outputs to a custom path
use-config: get
	mason make flutter_saas_brick \
		-c config.json \
		-o $(or $(dir),./output) \
		--on-conflict overwrite

# Bundle the brick into a Dart file (for brickhub.dev embedding)
bundle:
	mason bundle . -t dart -o ./

# Publish to brickhub.dev (requires `mason login` first)
publish:
	mason publish
