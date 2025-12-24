#!/usr/bin/env bash
set -euo pipefail

# Create ./src/System.db as the first concrete "System artifact" for pre-alpha-3.
# Requires: sqlite3

DB_PATH="./src/System"
mkdir -p "$(dirname "$DB_PATH")"
rm -f "$DB_PATH"

sqlite3 "$DB_PATH" <<'SQL'
PRAGMA journal_mode = WAL;
PRAGMA foreign_keys = ON;

-- -----------------------------
-- Minimal property-graph schema
-- -----------------------------
CREATE TABLE nodes (
  id        TEXT PRIMARY KEY,
  type      TEXT NOT NULL,
  label     TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now'))
);

CREATE TABLE edges (
  id        TEXT PRIMARY KEY,
  src       TEXT NOT NULL,
  rel       TEXT NOT NULL,
  dst       TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now')),
  FOREIGN KEY(src) REFERENCES nodes(id) ON DELETE CASCADE,
  FOREIGN KEY(dst) REFERENCES nodes(id) ON DELETE CASCADE
);

CREATE TABLE kv (
  owner_id  TEXT NOT NULL,
  k         TEXT NOT NULL,
  v         TEXT NOT NULL,
  PRIMARY KEY(owner_id, k),
  FOREIGN KEY(owner_id) REFERENCES nodes(id) ON DELETE CASCADE
);

-- ---------------------------------------
-- Seed: SYSTEM root + META + System Rules
-- ---------------------------------------
INSERT INTO nodes (id, type, label) VALUES
  ('SYSTEM', 'System', 'The System'),
  ('META',   'Element', 'Meta'),
  ('RULES_SYSTEM', 'Rule', 'System Rules');

INSERT INTO edges (id, src, rel, dst) VALUES
  ('E_SYSTEM_META', 'SYSTEM', 'HAS_ELEMENT', 'META'),
  ('E_META_RULES',  'META',   'HAS_RULE',    'RULES_SYSTEM');

-- Version + First Rule (symbolic self-reference via properties)
INSERT INTO kv (owner_id, k, v) VALUES
  ('SYSTEM', 'version', '0.0.0-pre-alpha-3'),
  ('SYSTEM', 'first_rule_ref', 'RULES_SYSTEM'),
  ('RULES_SYSTEM', 'first_rule', 'The First Rule is that the Alchemist is in control.');

-- ---------------------------------------
-- Invariants: prevent mutating SYSTEM node
-- ---------------------------------------
CREATE TRIGGER protect_system_node_update
BEFORE UPDATE ON nodes
WHEN OLD.id = 'SYSTEM'
BEGIN
  SELECT RAISE(ABORT, 'SYSTEM node is immutable (First Rule may not be Transmuted).');
END;

CREATE TRIGGER protect_system_node_delete
BEFORE DELETE ON nodes
WHEN OLD.id = 'SYSTEM'
BEGIN
  SELECT RAISE(ABORT, 'SYSTEM node cannot be deleted.');
END;

-- Optional: keep first_rule_ref stable once set
CREATE TRIGGER protect_first_rule_ref_update
BEFORE UPDATE ON kv
WHEN OLD.owner_id = 'SYSTEM' AND OLD.k = 'first_rule_ref'
BEGIN
  SELECT RAISE(ABORT, 'first_rule_ref is immutable once set.');
END;

-- Quick sanity check output
.headers on
.mode column
SELECT * FROM nodes ORDER BY id;
SELECT owner_id, k, v FROM kv ORDER BY owner_id, k;
SQL

echo
echo "Created: $DB_PATH"
echo "Tip: commit it as the single ./src/ artifact for pre-alpha-3."

