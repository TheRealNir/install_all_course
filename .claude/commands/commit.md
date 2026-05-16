# Commit

Check the current git status, summarize the changed files, suggest a clear commit message, and ask for confirmation before committing.

Steps:

1. Run `git status --short`.
2. Review the diff with `git diff` and `git diff --cached`.
3. Summarize the changes in plain language.
4. Suggest one concise commit message.
5. Ask before running `git add` or `git commit`.
6. Commit only the files relevant to the requested change.

Do not push unless explicitly asked.
