### git rebase 技巧
> source https://stackoverflow.com/questions/3042437/how-to-change-the-commit-author-for-a-single-commit

Interactive rebase off of a point earlier in the history than the commit you need to modify (git rebase -i <earliercommit>). In the list of commits being rebased, change the text from pick to edit next to the hash of the one you want to modify. Then when git prompts you to change the commit, use this:

```bash
git commit --amend --author="Author Name <email@address.com>" --no-edit
```
For example, if your commit history is A-B-C-D-E-F with F as HEAD, and you want to change the author of C and D, then you would...

Specify `git rebase -i B` (here is an example of what you will see after executing the `git rebase -i B` command)

if you need to edit A, use `git rebase -i --root`

Change the lines for both `C` and `D` from pick to edit

Exit the editor (for vim, this would be pressing Esc and then typing `:wq`).

Once the rebase started, it would first pause at `C`
  
You would 
```bash
git commit --amend --author="Author Name <email@address.com>"
```
Then 
```bash
git rebase --continue
```
It would pause again at D
Then you would 
```bash
git commit --amend --author="Author Name <email@address.com>" again

git rebase --continue
```
The rebase would complete.

Use `git push -f` to update your origin with the updated commits.


### Check out the empty branch
source: https://stackoverflow.com/questions/34100048/create-empty-branch-on-github
```bash
git switch --orphan <new branch>
git commit --allow-empty -m "Initial commit on orphan branch"
git push -u origin <new branch>
```
