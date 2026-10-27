#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "$0")" && pwd)"
build_dir="$script_dir/.standalone"
mkdir -p "$build_dir/Vasquez26HeterogeneousVerification"
cp "$script_dir"/*.lean "$build_dir/Vasquez26HeterogeneousVerification/"
cat > "$build_dir/Vasquez26HeterogeneousVerification.lean" <<'EOF'
import Vasquez26HeterogeneousVerification.ProofInterface
EOF
cat > "$build_dir/lakefile.toml" <<'EOF'
name = "vh26"
version = "0.1.0"
defaultTargets = ["Vasquez26HeterogeneousVerification"]
[[require]]
name = "mathlib"
git = "https://github.com/leanprover-community/mathlib4.git"
rev = "5450b53e5ddc75d46418fabb605edbf36bd0beb6"
[[lean_lib]]
name = "Vasquez26HeterogeneousVerification"
EOF
printf '%s\n' 'leanprover/lean4:v4.30.0-rc2' > "$build_dir/lean-toolchain"
cd "$build_dir"
lake update
lake exe cache get
lake build +Vasquez26HeterogeneousVerification
