# Git Hooks Toolkit

> A reusable Git hooks setup that enforces commit quality, branch naming, secret protection, formatting, and basic repository hygiene — language agnostic, and compatible with React, TypeScript, Go, Docker, and typical backend stacks.

---

## What This Provides

| Hook                                   | Purpose                                                     |
| -------------------------------------- | ----------------------------------------------------------- |
| Conventional commit message validation | Ensures commit messages follow a consistent format          |
| Branch naming validation               | Enforces naming conventions before push                     |
| Secret leak detection                  | Powered by [Gitleaks](https://github.com/gitleaks/gitleaks) |
| `.env` push protection                 | Blocks `.env` files; allows `.example` variants             |
| Large file guard                       | Prevents bloated commits                                    |
| Formatter / linter orchestration       | Via `lint-staged`                                           |
| Dockerfile linting                     | Via `hadolint`                                              |
| YAML linting                           | Via `yamllint`                                              |

The same checks can be reused directly in CI.

---

## Repository Structure

```
.githooks/
  pre-commit
  commit-msg
  pre-push

scripts/
  install.sh

test-hooks.sh
```

---

## Installation

### Option 1 — Per Project (Recommended)

Clone hooks into your project and run the install script:

```bash
git clone https://github.com/aryan083/git-hooks.git .githooks-repo
bash .githooks-repo/scripts/install.sh
```

This configures:

```bash
git config core.hooksPath .githooks-repo/.githooks
```

### Option 2 — Repo Local (`.githooks` committed)

If this repo already contains `.githooks`, simply run:

```bash
git config core.hooksPath .githooks
```

### Option 3 — Global (All Repos)

```bash
git clone https://github.com/aryan083/git-hooks.git ~/.githooks
git config --global core.hooksPath ~/.githooks/.githooks
```

---

## Dependencies

### Core (Required)

- **Git**
- **Node.js** — for `lint-staged` / Prettier

### Security (Required)

- **Gitleaks** — secret scanning

### Optional

These enhance the checks but are not mandatory:

- **Prettier** — code formatting
- **ESLint** — JavaScript/TypeScript linting
- **Hadolint** — Dockerfile linting
- **Yamllint** — YAML linting
- **Go toolchain** — Go project support

---

## Installing Dependencies

### Node Tools

Inside your project:

```bash
npm install -D lint-staged prettier eslint
```

Add to `package.json`:

```json
"lint-staged": {
  "*.{ts,tsx,js,jsx,json,css,md}": "prettier --write"
}
```

### Gitleaks

**macOS**

```bash
brew install gitleaks
```

**Linux**

```bash
sudo apt install gitleaks
```

Or download a binary from the [releases page](https://github.com/gitleaks/gitleaks/releases).

**Windows**

```powershell
winget install Gitleaks.Gitleaks
```

### Hadolint

**macOS**

```bash
brew install hadolint
```

**Linux**

```bash
sudo wget -O /usr/local/bin/hadolint \
  https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64
sudo chmod +x /usr/local/bin/hadolint
```

**Windows** — Download binary and add to `PATH`.

### Yamllint

```bash
pip install yamllint
```

### Prettier

```bash
npm install -D prettier
```

Optional config: `.prettierrc`

---

## What Gets Blocked vs. Allowed

### ❌ Blocked

- Invalid commit messages
- Invalid branch names
- Secrets in staged changes
- `.env` files being committed
- Large files
- Broken formatting (via `lint-staged`)

### ✅ Allowed

- `.env.example` / `.env.local.example`
- Documentation-only changes
- Tag pushes

---

## Testing Hooks

```bash
bash test-hooks.sh
```

Validates:

- Formatting
- `.env` protection
- Secret detection
- Commit message validation
- Branch name validation

---

## Troubleshooting

### Hooks Not Running

Verify the hooks path is set:

```bash
git config core.hooksPath
```

Ensure hook scripts are executable:

```bash
chmod +x .githooks/*
```

### `lint-staged` Stuck

Ensure `package.json` exists and `lint-staged` is properly configured.

### Windows Line Ending Warnings

Safe to ignore. To suppress:

```bash
git config core.autocrlf true
```

---

## Philosophy

- **Fast feedback locally** — catch issues before they reach CI
- **Same rules as CI** — no surprises at push time
- **Minimal dependencies** — lightweight and easy to audit
- **Language agnostic** — works across stacks
- **Easy team onboarding** — one install command, zero config drift

---

## Roadmap

- [ ] Configurable rules file
- [ ] CI mirror workflow
- [ ] Automatic changelog generation
- [ ] Versioned hook releases
- [ ] Performance caching

---

## License

MIT
