mklink  .vimrc .vim\vimrc
mklink  .vrapperrc .vim\vrapper\_vrapperrc

set path=%path%;C:\Program Files (x86)\Git\bin;C:\Program Files (x86)\Vim\vim74

vim +BundleInstall! +qall
