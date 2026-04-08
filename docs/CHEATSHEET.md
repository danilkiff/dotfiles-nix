# Engineering CLI cheat-sheet

Quick map from standard GNU/Linux tools to the modern replacements
installed on this machine. Stick with the standard tool when you want
muscle memory or scripting portability — reach for the replacement when
you want speed, color, or a TUI.

## File search & navigation

| Standard           | Replacement | Notes                                            |
| ------------------ | ----------- | ------------------------------------------------ |
| `find . -name 'X'` | `fd X`      | Smart-case, ignores `.git`, parallel.            |
| `ls -lah`          | `eza -lah`  | Aliased to `ls`/`ll`/`la`/`lt`. Adds git status. |
| `cd <dir>`         | `z <part>`  | Jump by frecency. `zi` for fuzzy interactive.    |
| `tree`             | `eza -T`    | Or keep `tree` — both installed.                 |

## Content viewing & search

| Standard         | Replacement   | Notes                                          |
| ---------------- | ------------- | ---------------------------------------------- |
| `grep -rn X .`   | `rg X`        | Respects `.gitignore`, parallel, smart-case.   |
| `cat file`       | `bat file`    | Syntax highlighting + paging. `bat -p` = raw.  |
| `less file.json` | `jless file`  | Folding, search, jq-style paths.               |
| `git diff`       | (auto-delta)  | `delta` is wired as git pager — no extra cmd.  |

## Disk & filesystem

| Standard | Replacement | Notes                                                |
| -------- | ----------- | ---------------------------------------------------- |
| `du -sh` | `dua`       | Multi-threaded. `dua i` = interactive browser.       |
| `du -sh` | `ncdu`      | Classic interactive TUI; slower but familiar.        |
| `df -h`  | `duf`       | Colored, groups by device type.                      |

## Process & system

| Standard     | Replacement | Notes                                          |
| ------------ | ----------- | ---------------------------------------------- |
| `top`/`htop` | `btop`      | GPU/CPU/disk/net in one screen, mouse support. |

## Network

| Standard           | Replacement      | Notes                                         |
| ------------------ | ---------------- | --------------------------------------------- |
| `traceroute` + ping | `mtr <host>`    | Live combined view, `-r` for batch report.    |
| `tcpdump`          | `wireshark`     | GUI; CLI capture still via `dumpcap`/`tshark`. |
| `dig`              | (kept)          | `dig` and `httpie` (`http`) both installed.   |

Wireshark capture works without sudo because the user is in the
`wireshark` group (configured in `user.nix`).

## Git

| Standard            | Replacement | Notes                                          |
| ------------------- | ----------- | ---------------------------------------------- |
| `git status` + `add` interactively | `lazygit` | Single-key staging, push, rebase. |
| `lazygit`           | `gitui`     | Rust alternative; lighter, fewer features.     |

## Performance & measurement

| Standard            | Replacement       | Notes                                       |
| ------------------- | ----------------- | ------------------------------------------- |
| `time cmd`          | `hyperfine cmd`   | Warmup + statistics over N runs.            |
| `wc -l **/*.go`     | `tokei`           | LoC by language, ignores generated files.   |

## Watchers & runners

| Standard                       | Replacement      | Notes                              |
| ------------------------------ | ---------------- | ---------------------------------- |
| `while inotifywait …; do …`    | `entr` / `watchexec` | `entr` is line-based (`ls *.go \| entr -r go test ./...`); `watchexec` is event-based. |
| `make`                         | `just`           | Per-project recipes in `justfile`. |

## Nix lifecycle (this repo)

| Old                              | New                       |
| -------------------------------- | ------------------------- |
| `sudo nixos-rebuild switch --flake .#llathasa` | `nh os switch .` |
| `nix-collect-garbage -d`         | `nh clean all`            |
| `nixos-rebuild build` + diff     | `nh os build` (uses `nvd`) |

`make` targets in this repo still work and are CI-aligned.

## Prompt notes

Prompt is `starship`. The Python segment is configured to always render
the active virtualenv (`$VIRTUAL_ENV`), and `VIRTUAL_ENV_DISABLE_PROMPT=1`
is set so `source venv/bin/activate` does not double-print it. Nix
devshells also light up the prompt via the `nix_shell` module.
