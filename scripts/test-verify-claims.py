#!/usr/bin/env python3
"""Regression checks for live observations and commit-pinned verification."""
import re
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

SCRIPT = Path(__file__).resolve().parents[1] / 'full-context-templates/scripts/verify-claims.sh'


class VerifyClaimsTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='banka-verify-')
        self.addCleanup(self.temp.cleanup)
        self.repo = Path(self.temp.name)
        (self.repo / 'scripts').mkdir()
        shutil.copy2(SCRIPT, self.repo / 'scripts/verify-claims.sh')
        self.git('init', '-q')
        (self.repo / 'file with spaces.txt').write_text('base\n')
        self.base = self.commit('base')

    def run_command(self, *args, check=True):
        return subprocess.run(args, cwd=self.repo, capture_output=True, text=True, check=check)

    def git(self, *args):
        return self.run_command('git', *args).stdout.strip()

    def commit(self, message):
        self.git('add', '.')
        self.git('-c', 'user.name=Audit Fixture', '-c', 'user.email=audit@example.invalid',
                 '-c', 'commit.gpgsign=false', 'commit', '-qm', message)
        return self.git('rev-parse', 'HEAD')

    def verify(self, *args):
        return self.run_command('bash', 'scripts/verify-claims.sh', *args).stdout

    def test_pinned_evidence_survives_head_and_worktree_changes(self):
        target = self.repo / 'file with spaces.txt'
        target.write_text('changed\n')
        revision = self.commit('change')
        args = ('--revision', revision, '--check-file', target.name, '--check-diff', target.name)
        before = self.verify(*args)
        self.assertEqual(before.count('| MET |'), 2)
        self.assertIn('--revision ' + revision, before)
        target.unlink()
        self.commit('delete')
        target.write_text('untracked replacement\n')
        self.assertEqual(before, self.verify(*args))
        self.assertIn('| MISSING |', self.verify('--revision', self.base, '--check-file', 'missing'))
        self.assertIn('| MISSING |', self.verify('--revision', revision, '--check-diff', 'missing'))
        # Replay the exact shell-quoted flags printed for a path with spaces.
        flags = re.search(r'\| `([^`]+)` \| MET', before).group(1)
        replay = self.run_command('bash', '-c', 'bash scripts/verify-claims.sh ' + flags).stdout
        self.assertIn('| MET |', replay)

    def test_live_dirty_evidence_is_explicitly_nonreplayable(self):
        target = self.repo / 'file with spaces.txt'
        target.write_text('dirty\n')
        before = self.verify('--check-diff', target.name)
        self.assertIn('| MET | live observation:', before)
        self.assertIn('not preserved', before)
        self.git('restore', '--', target.name)
        self.assertIn('| BLOCKED |', self.verify('--check-diff', target.name))
        self.assertEqual(self.git('rev-parse', 'HEAD'), self.base)

    def test_first_commit_and_shallow_parent_are_blocked(self):
        self.assertIn('| BLOCKED |', self.verify('--revision', self.base, '--check-diff', 'file with spaces.txt'))
        (self.repo / 'file with spaces.txt').write_text('next\n')
        revision = self.commit('next')
        shallow = self.repo / 'shallow-copy'
        self.git('clone', '-q', '--depth=1', self.repo.as_uri(), str(shallow))
        result = subprocess.run(['bash', 'scripts/verify-claims.sh', '--revision', revision,
                                 '--check-diff', 'file with spaces.txt'], cwd=shallow,
                                capture_output=True, text=True, check=True)
        self.assertIn('| BLOCKED |', result.stdout)

    def test_revision_validation_prevents_live_test_execution(self):
        bad = self.run_command('bash', 'scripts/verify-claims.sh', '--revision', 'missing-ref',
                               '--check-file', 'x', check=False)
        self.assertNotEqual(bad.returncode, 0)
        self.assertIn('BLOCKED', bad.stderr)
        for args in [('--revision', self.base, '--run-test', 'touch should-not-exist'),
                     ('--run-test', 'touch should-not-exist', '--check-file')]:
            result = self.run_command('bash', 'scripts/verify-claims.sh', *args, check=False)
            self.assertNotEqual(result.returncode, 0)
            self.assertFalse((self.repo / 'should-not-exist').exists())
        result = self.verify('--run-test', 'true', '--run-test', 'false')
        self.assertIn('Live observation only', result)
        self.assertIn('| MET |', result)
        self.assertIn('| MISSING |', result)


if __name__ == '__main__':
    unittest.main()
