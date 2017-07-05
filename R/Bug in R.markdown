
### Bugs

```
install.packages('mclust',type='source')
install.packages('gdtools',type='source')
install.packages("stringi",type='source') # warnings
install.packages("tseries",type='source')
```
### Sove problems

http://stackoverflow.com/questions/37753941/os-x-package-installation-issue-cant-find-gfortran-4-8-to-build-package

1. install gfortran 6.3 from https://gcc.gnu.org/wiki/GFortranBinaries#MacOS
2. Then, I added the following to the file ~/.R/Makevars within my home directory pointing to my gfortran installation:

```
F77 = gfortran
FC = gfortran
FLIBS = -L/usr/local/gfortran/lib
CXXFLAGS += -O3 -Wall -pipe -Wno-unused
```

3. brew install cairo

```
brew install cairo
```
