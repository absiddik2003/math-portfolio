# Mathematics Portfolio - Project Context & Rules

## Author & Identity
- **Author**: Md Abubakar Siddik (`absiddik2003`)
- **Email**: `2212052@name.buet.ac.bd`
- **Repository**: [absiddik2003/math-portfolio](https://github.com/absiddik2003/math-portfolio)
- **Primary Branch**: `main`

## Project Scope & Organization
Chapter 19 Mathematics Portfolio documenting solutions, scans, proofs, and study progress:
- `proofs/munkres-topology/` - General topology (Ch. 2 Set Theory, Ch. 3 Connectedness & Compactness)
- `proofs/barnard-child-number-theory/` - Higher algebra & number theory (e.g., Exercise XLIII)
- `proofs/rudin-real-analysis/` - Principles of Mathematical Analysis
- `proofs/dummit-foote-algebra/` - Abstract algebra
- `notes/`, `thesis/`, `code/`, `exams/` - Supporting research, thesis materials, scripts, and exam solutions
- `STUDY-LOG.md` - Chronological log of weekly topics, completed proofs, and unresolved steps

## Guidelines & Best Practices
1. **Empty Directories**: Git does not track empty folders. `sync.bat` now automatically creates `.gitkeep` in any empty folders before syncing so you never have to copy-paste them manually.
2. **Syncing to GitHub**: 
   - `sync.bat` in the repository root automatically auto-detects empty directories, stages, commits with timestamp, and pushes all local changes to `origin/main`.
   - Cached GitHub credentials through Git Credential Manager are pre-configured.
