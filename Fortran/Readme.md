This project was originally [here](https://github.com/hunar1997/neural_network_from_scratch)

To compile, just use: `gfortran filename.f90` and run the output file called `a.out` or `a.exe`

If you are using vim, add this line `nnoremap <F9> :w<CR>:!gfortran %<CR>:!./a.out<CR>` to your .vimrc, then in normal mode press F9 to save+compile+run your fortran code

I used `real` for real numbers, you can use `real(8)` or `real(16)` if you want more precise results
