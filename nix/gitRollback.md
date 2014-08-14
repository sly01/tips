```git revert commitId --> It takes a commit message and revert it to what step you want to go```

```
git commit --amend --> If you add a new file or change the code with out adding extra commit. Basically it change the last commit.
```
```
git reset --soft HEAD~n  --> It doesn't delete the file just delete the last commit.
```
```
git reset --hard commitId or HEAD~n --> It deletes the file and last commit.
```