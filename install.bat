mklink  .vimrc .vim\vimrc
mklink  .vrapperrc .vim\vrapper\_vrapperrc
mklink  .ideavimrc  .vim\ideavim\_ideavimrc

set path=%path%;C:\Program Files (x86)\Git\bin;C:\Program Files (x86)\Vim\vim74

vim +BundleInstall! +qall
