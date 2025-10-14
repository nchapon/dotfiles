#!/usr/bin/env python3
"""
Backup files to a git bare repository on a USB key
"""

import os
import sys
import subprocess
import argparse
from pathlib import Path
from datetime import datetime

class GitBackup:
    def __init__(self, source_dir, bare_repo_path, work_tree=None):
        self.source_dir = Path(source_dir).resolve()
        self.bare_repo_path = Path(bare_repo_path).resolve()
        self.work_tree = Path(work_tree).resolve() if work_tree else self.source_dir
        
        if not self.source_dir.exists():
            raise ValueError(f"Source directory does not exist: {self.source_dir}")
    
    def run_git(self, *args, capture=True):
        """Run git command with bare repo configuration"""
        cmd = [
            'git',
            f'--git-dir={self.bare_repo_path}',
            f'--work-tree={self.work_tree}',
            *args
        ]
        
        try:
            if capture:
                result = subprocess.run(cmd, capture_output=True, text=True, check=True)
                return result.stdout.strip()
            else:
                subprocess.run(cmd, check=True)
                return None
        except subprocess.CalledProcessError as e:
            print(f"Git command failed: {' '.join(cmd)}")
            if e.stderr:
                print(f"Error: {e.stderr}")
            raise
    
    def init_repo(self):
        """Initialize bare repository if it doesn't exist"""
        if self.bare_repo_path.exists():
            print(f"Bare repository already exists at: {self.bare_repo_path}")
            return
        
        print(f"Initializing bare repository at: {self.bare_repo_path}")
        self.bare_repo_path.parent.mkdir(parents=True, exist_ok=True)
        subprocess.run(['git', 'init', '--bare', str(self.bare_repo_path)], check=True)
        
        # Initial commit
        try:
            self.run_git('add', '.')
            self.run_git('commit', '-m', 'Initial backup')
            print("Initial backup complete")
        except subprocess.CalledProcessError:
            print("No files to commit in initial backup")
    
    def get_status(self):
        """Get repository status"""
        try:
            status = self.run_git('status', '--short')
            return status
        except subprocess.CalledProcessError:
            return None
    
    def backup(self, message=None):
        """Perform backup by committing changes"""
        print(f"Backing up from: {self.work_tree}")
        print(f"To bare repo: {self.bare_repo_path}\n")
        
        # Add all changes
        self.run_git('add', '-A')
        
        # Check if there are changes
        status = self.get_status()
        if not status:
            print("✓ No changes to backup")
            return
        
        print("Changes to backup:")
        print(status)
        print()
        
        # Commit changes
        if message is None:
            message = f"Backup on {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
        
        self.run_git('commit', '-m', message)
        print(f"✓ Backup complete: {message}")
    
    def show_log(self, n=10):
        """Show recent backup history"""
        try:
            log = self.run_git('log', f'-{n}', '--oneline', '--decorate')
            print("Recent backups:")
            print(log)
        except subprocess.CalledProcessError:
            print("No backup history yet")
    
    def show_diff(self):
        """Show uncommitted changes"""
        try:
            diff = self.run_git('diff', '--stat')
            if diff:
                print("Uncommitted changes:")
                print(diff)
            else:
                print("No uncommitted changes")
        except subprocess.CalledProcessError:
            print("Cannot show diff")

def main():
    parser = argparse.ArgumentParser(
        description='Backup files to a git bare repository',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  # Initialize and perform first backup
  %(prog)s --source ~/Documents --bare /media/usb/backup.git --init
  
  # Perform regular backup
  %(prog)s --source ~/Documents --bare /media/usb/backup.git
  
  # Backup with custom message
  %(prog)s --source ~/Documents --bare /media/usb/backup.git -m "Weekly backup"
  
  # Show backup history
  %(prog)s --source ~/Documents --bare /media/usb/backup.git --log
        '''
    )
    
    parser.add_argument('--source', '-s', required=True,
                        help='Source directory to backup')
    parser.add_argument('--bare', '-b', required=True,
                        help='Path to bare git repository (e.g., /media/usb/backup.git)')
    parser.add_argument('--work-tree', '-w',
                        help='Work tree path (defaults to source directory)')
    parser.add_argument('--init', action='store_true',
                        help='Initialize the bare repository')
    parser.add_argument('--message', '-m',
                        help='Commit message for backup')
    parser.add_argument('--log', action='store_true',
                        help='Show backup history')
    parser.add_argument('--diff', action='store_true',
                        help='Show uncommitted changes')
    parser.add_argument('--status', action='store_true',
                        help='Show current status')
    
    args = parser.parse_args()
    
    try:
        backup = GitBackup(args.source, args.bare, args.work_tree)
        
        if args.init:
            backup.init_repo()
        
        if args.log:
            backup.show_log()
        elif args.diff:
            backup.show_diff()
        elif args.status:
            status = backup.get_status()
            if status:
                print("Current status:")
                print(status)
            else:
                print("✓ Working tree clean")
        else:
            backup.backup(args.message)
    
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()
