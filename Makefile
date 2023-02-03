test:
	stack test

bin:
	stack build

clean:
	stack clean

upstream:
	git remote add upstream https://github.com/ucsd-cse130-mhb/03-recursive.git

update:
	git pull upstream main

turnin:
	git commit -a -m "turnin"
	git push origin main

lec7:
	stack test --test-arguments='--match "Lecture 7"'
lec8:
	stack test --test-arguments='--match "Lecture 8"'
lec9:
	stack test --test-arguments='--match "Lecture 9"'
lec10:
	stack test --test-arguments='--match "Lecture 10"'
