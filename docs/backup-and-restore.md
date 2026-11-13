# Backup and restore ("chapters"): design r1 (13 Nov 26)

Status: design after PFM 20A (12 Nov): weekly automatic backup, browsable in the app, with a way to roll back. Items marked **REC:** are open until the PFM approves; **Test** = not proven on the tenant.

## 1. Three layers, smallest first

| Layer | Covers | How the app shows it | Restore keeps lookups intact |
|---|---|---|---|
| 1. Row history (SharePoint version history, on by default) | A wrong edit on one row | "History" panel on a row: each version, who, when, what changed | Yes: a flow copies the old values onto the same row (same ID) |
| 2. Recycle bin (93 days) | A deleted row or file | "Deleted" screen, PFM Office only | Yes: SharePoint restores the original ID |
| 3. Chapters (weekly snapshot) | A bad bulk change, a deleted list, anything older than 93 days | "Chapters" screen: one entry per week, row counts per list, the Activity Log events of that week as the chapter summary | Partly: see section 3 |

## 2. Chapters

- Flow "90-161.Z - Weekly Backup": every Sunday 0300 (time zone from PFM Settings). For each PFM list it writes one JSON file (all columns, IDs and lookup IDs: the restore source) and one CSV file (for people, opens in Excel) to Record Sets/Backups/<yyyy-mm-dd>/. It writes one PFM Activity Log row with the counts.
- **REC:** Q23 retention: the last 8 weekly chapters plus the first chapter of each month for 12 months (20 folders at most).
- Chapters screen (PFM Office only): pick a chapter, see per list "rows then / rows now / changed / deleted since", open a row as it was.

## 3. Rollback from a chapter

- **Selective (REC default):** the PFM picks rows or fields in a chapter; a flow writes those values back onto the same rows. Deleted rows come back from the recycle bin first (same ID); only past 93 days is a row created new.
- **Whole list (PFM Office, confirm twice):** before it starts, the flow takes a fresh chapter, so the rollback itself can be undone. Then it sets every row to its chapter values and lists rows created since the chapter for the PFM to keep or delete.
- Limit (high confidence): SharePoint gives a re-created row a new ID; it cannot reuse the old one. Rows in other lists that pointed to it (Endorsements to Publications, forms to their prescribing publication) are re-pointed by the flow through the IDs stored in the JSON. **Test:** re-pointing on the test site before the pilot.
- Every restore is logged (who, which chapter, which rows).

## 4. Open questions

| Q | Question | Options | REC |
|---|---|---|---|
| Q22 | Rollback scope | A: all three layers; whole-list rollback by PFM Office only, with an automatic chapter first. B: row history and recycle bin only; chapters are read-only | A |
| Q23 | Chapter retention | A: 8 weekly + 12 monthly. B: 8 weekly only | A (a yearly review often looks back more than 2 months) |
